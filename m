Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35119CC6B19
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 05:22:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F3AD10E065;
	Wed, 14 Oct 2026 05:22:03 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71FEA10E065
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 05:21:52 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69E2TjnY3001160
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 05:21:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +tmeHKXlwKajtwfy7oLy0X/GGrLlKfCh9j2G3mpjqNg=; b=CtTr0cdDc9I9YEYK
 MIciJkpVv5UsiYAqdcyE0f7a0/jfs7xjP93Xe9L4ZwFFfGWhAk+NcGqrOGZpvYd2
 txkIle81II0Jbxwf8bRhPnM76+YPNTp0nzJSmX2HgvlMUHDBze3c25Q16VezldAq
 UUqV9ff+LP4V6IE9QkBLnlpukr5sUxSPC8HPNFGesd4EVZ4GLHC7g4W6N+0K0hSp
 Pqrfhlh3xk2LDx25brlWYcPoMgKL0pt6owMo0DPklkIIKJmFL8/wx4pOFdX9lNlQ
 aS37d0b+q5a98MbalVMolZPSUwfnZMoGpeRs9KBPqzp3ylGceqFRVBVhHFhC9bnf
 rKQh6w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9sbetacd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 05:21:51 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-39deda201bcso6112796a91.2
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 22:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791955311; x=1792560111;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+tmeHKXlwKajtwfy7oLy0X/GGrLlKfCh9j2G3mpjqNg=;
 b=VCZNHBasxZRQOKq+B1ElLWfkJvYYAVCpPRqh4k1q6Mjp2xzlBunZtUakzYWHMNUWKi
 tKl/u+u0ci3luELrbW/6dAgnyn8KduDI0WGs65Avr7yFw//IR/GjHPLhF3L7IBoxjey4
 FUaYCmhX/Gtf1XOGbT3W482RWjEJ6b+vY9K4AOdHBETL4ARqQ2vEAN0/hMIoid3qox34
 CZY8WyLhK517ZxoxYOUCS5c7exMU5hYWxuEaxxhv74EyazkT8fcbGseEZUJmmYOqCRg/
 oAUsmNfLVYqpuIqzs/9o2fRQTr0dNLbpj4KyCsBYVeGKwSv30Rw1a8gNcinLYjBQiBdc
 aiQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791955311; x=1792560111;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+tmeHKXlwKajtwfy7oLy0X/GGrLlKfCh9j2G3mpjqNg=;
 b=CDIEIrUCo2reztlMiR+IrjDCj9YHV7dLKjyuR3p/f21vxDy1LxbUfdY2X4DujH3Ry6
 86GV7uozD4titr4RlmBEaT6Hj8I1IBtG7XwtYA3NXvnHZIRAXytEHdDq/BuHX03DCzE7
 3aU3Hm0RmfdVMmL2KE36S2cBBu0BY7Ok4G6eaYDRv2EcF+0NQLrT3hD/VYZKQpdjaIlN
 8oGiHeb++aw5BtFcdPU+lP1qo/IIAFHsHG5knbm0tVXKTdhKSaJ9c6sgNnFo6vDkFwoq
 cMh+Ed3cOPrnKcanWb5DtJ1qHYYKqxcBQY6a/2PSKAo6xVjRw2xfpNrGLe7XdaADJttA
 +rlg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzvrvE2wm8y74KlbZzPcYrZW5jmd1ADZCrr1bMxvYxjoef3vUlEMAEhqAStfZEOe9TTGZkso1FiSD0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIPnlI91xKhBkjcNfVnbgu5TXvb8CfYW9Q570XxvhP7pm62Sjb8
 8zN6fRMLT82boB6B0BnSGJywtoEDKQPq2hxEjBjyUbazJkV20wwGFO8ta4rkb4hQ9JqaXkgi3rD
 tip5Yxdp9s9lkeN+nCx8lMe5yDkifQNx9nRhvNSYJnL2+PurjzkvgsSFhESoWF3S5JC+oXKA=
X-Gm-Gg: AYBFou1Gc7t1MSCvEwf700E4ewosTWGFbEBZsTAmmEXeEvACYeZYl8CuM7aCH+f49lm
 kbxUNB/aHhUG5ZUyv6QRFvMbwdPLDKTgzUED9B3jvr8jM6MJ1YWrd4SaKwdgogEQEMnWAhFK1H3
 CEAOn5XiomoUmbF1jpOLR+cZ55yqCJhJQ6YREgPrlmlr4mnL27ZY8nu/1gT1c/NZ30JwRFN5POe
 PupCDbX5ZcBTimX2gP8bYCLnTDpHW0yOzAa7A3XXC7AOwM1dSU29YmHq5TvV4uNpK6uZJgkhFlF
 M3Byj9W3iyBQYxy3IYOe2iUaearZ0SgK2b4oVjYR+/v6kECLh86o5BgR9wyc1r0Vyg6ofyGzV1k
 w64gOaaVFGOMHxyaPsqeU6nJwqDEo
X-Received: by 2002:a17:90b:544f:b0:3a7:8c68:6446 with SMTP id
 98e67ed59e1d1-3ab3acf5d75mr11891809a91.63.1791955310822; 
 Tue, 13 Oct 2026 22:21:50 -0700 (PDT)
X-Received: by 2002:a17:90b:544f:b0:3a7:8c68:6446 with SMTP id
 98e67ed59e1d1-3ab3acf5d75mr11891790a91.63.1791955310244; 
 Tue, 13 Oct 2026 22:21:50 -0700 (PDT)
Received: from [10.219.56.188] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac77441306sm270844a91.2.2026.10.13.22.21.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 22:21:49 -0700 (PDT)
Message-ID: <cf34e58c-29cd-411e-b2fd-e5c6e2fcac08@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 10:51:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] misc: fastrpc: map ADSP remote heap into remoteproc
 IOMMU domain
To: Anandu Krishnan E <anandu.e@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, quic_bkumar@quicinc.com,
 quic_chennak@quicinc.com
References: <20261001-fastrpc-kvm-iommu-v2-v2-1-6c32ad6f662f@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20261001-fastrpc-kvm-iommu-v2-v2-1-6c32ad6f662f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 9jPUVDk5I7dkQjohrXOhTUGgZGTommgO
X-Proofpoint-GUID: 9jPUVDk5I7dkQjohrXOhTUGgZGTommgO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAyMSBTYWx0ZWRfX5/y7ymkq/B15
 iGO8Uk1G/OBhf5o1cAEFcUcjR8/AfOEU62r+gEIcCO4dXav4rKMVOMg6QJMibqZMag727q1oRJs
 n+ra3pf3emYKjYbCLhwW/dgRSVpwshm54xK5gMMoKZoKgeY/lfz0AnNflUTIuuv+lcKi2WcnsZz
 u230K3pLXTzt1XvIf6GkR6bjcbG6kpHzbTnAUJNec5dIO8Td7PatOAUlGqTBA6Qm2fSsU64Gby7
 b/bDdfqopaZxOxb73lf6E4NG3scpvAq+LiPsn/+ox87VR3IW+DsqsM6WeSOfNjEY++lfH2Tc9BH
 jA99a28xpJ5YxvKbtm8zO4ccOECUE50BsBUF1wTevEGroCe+pHxcoRInE3sflDVaDuPVnuQYLpl
 /fPznuYjoRTczCHeER5N1acMHYcCkpvD0qOdg2bC63QPNw86AMBcZ8HLtr+iuzc75IzlYghanio
 HWZWKB/unbu6WFWLggw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAyMSBTYWx0ZWRfXxyMfJAiAUDmG
 qaFQZcwnRjNI8HfU1BNhkk3iMR1CdlVm6quF3WXdP2ikWJxmCzYVMEjqRhXsM44jEhuvW5h/6eq
 MwqgxK9c+SosSoqDPWRoHKZk2GsdJ/4=
X-Authority-Analysis: v=2.4 cv=U7AHnuru c=1 sm=1 tr=0 ts=6acf116f cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ag1SF4gXAAAA:8 a=e5mUnYsNAAAA:8
 a=COk6AnOGAAAA:8 a=-BeeMIvaIu40gwv0EBMA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=Vxmtnl_E_bksehYqCbjh:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140021
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 01-10-2026 20:30, Anandu Krishnan E wrote:
> On KVM-based targets the kernel runs at EL2 without a separate
> hypervisor to manage inter-VM memory access control.  In this
> configuration the remoteproc is assigned its own IOMMU domain, and
> any memory carveout the DSP must access requires an explicit mapping
> into that domain before the DSP can reach it.
> 
> The existing code calls qcom_scm_assign_mem() to transfer ownership
> of the ADSP remote heap carveout from HLOS to the DSP VM.  This SCM
> call is only meaningful when a separate hypervisor (e.g. Gunyah) is
> present to enforce inter-VM memory access control.  On KVM-based
> targets no such hypervisor exists, so the carveout must instead be
> mapped into the remoteproc's IOMMU domain via an identity mapping
> (IOVA == PA) using iommu_map().  Without this mapping the DSP
> triggers an SMMU translation fault when accessing the remote heap
> during audio PD static process creation.
> 
> Detect whether the remoteproc has an IOMMU by checking for the
> "iommus" property on the remoteproc DT node and store the result in
> a new use_iommu_map flag in fastrpc_channel_ctx.  When the flag is
> set, map the carveout into the remoteproc's IOMMU domain instead of
> calling qcom_scm_assign_mem().  Introduce fastrpc_remote_heap_map()
> and fastrpc_remote_heap_unmap() helpers to encapsulate the IOMMU
> domain lookup and map/unmap operations.
> 
> Signed-off-by: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
> To: Srinivas Kandagatla <srini@kernel.org>
> To: Amol Maheshwari <amahesh@qti.qualcomm.com>
> To: Arnd Bergmann <arnd@arndb.de>
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Cc: ekansh.gupta@oss.qualcomm.com
> Cc: quic_bkumar@quicinc.com
> Cc: quic_chennak@quicinc.com
> ---
> Changes in v2:
> - Rebase onto the fastrpc-for-next tree, which now has the remote
>   heap allocation and reserved-memory handling changes.
> - Rename has_iommu to use_iommu_map for clarity.
> - In fastrpc_rpmsg_remove(), the IOMMU unmap path now mirrors the
>   qcom_scm_assign_mem() path exactly, so the two are handled
>   consistently instead of leaving the IOMMU case with different
>   cleanup semantics.
> - Add fastrpc_get_rproc_node() to fix a device_node refcount leak:
>   the previous of_get_parent(of_get_parent(node)) pattern never put
>   the intermediate parent node.
> - Unmap the remote heap from the remoteproc's IOMMU domain if probe
>   fails after the mapping succeeds, instead of leaking the mapping
>   and causing -EEXIST on every subsequent probe attempt.
> - Log a warning in fastrpc_remote_heap_unmap() on each failure path
>   (remoteproc node/platform device/IOMMU domain not found, or a
>   partial iommu_unmap()), instead of silently leaving the mapping in
>   place with no diagnostic.
> 
> Link to v1: https://lore.kernel.org/r/20260618-audio_fix_clean_v3-v1-1-ec1ee66fe455@oss.qualcomm.com
> ---
>  drivers/misc/fastrpc.c | 149 ++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 128 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 5ac7b3e78ba7..89f4a80ad9be 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -21,6 +21,7 @@
>  #include <linux/slab.h>
>  #include <linux/firmware/qcom/qcom_scm.h>
>  #include <uapi/misc/fastrpc.h>
> +#include <linux/iommu.h>
nit: follow alphabetical order>  #include <linux/of_reserved_mem.h>
>  #include <linux/bitfield.h>
>  #include <linux/bits.h>
> @@ -317,6 +318,8 @@ struct fastrpc_channel_ctx {
>  	/* Audio PD reserved remote heap region */
>  	phys_addr_t remote_heap_addr;
>  	u64 remote_heap_size;
> +	/* set when remoteproc has an IOMMU; use iommu_map instead of hyp_assign */
> +	bool use_iommu_map;
>  	u32 dsp_attributes[FASTRPC_MAX_DSP_ATTRIBUTES];
>  	struct fastrpc_device *secure_fdevice;
>  	struct fastrpc_device *fdevice;
> @@ -2507,9 +2510,90 @@ static const struct of_device_id fastrpc_poll_supported_machines[] __maybe_unuse
>  	{},
>  };
>  
> +static struct device_node *fastrpc_get_rproc_node(struct device_node *node)
> +{
> +	struct device_node *parent, *rproc_node;
> +
> +	parent = of_get_parent(node);
> +	if (!parent)
> +		return NULL;
> +
> +	rproc_node = of_get_parent(parent);
> +	of_node_put(parent);
> +
> +	return rproc_node;
> +}
> +
> +static int fastrpc_remote_heap_map(struct device *rdev,
> +				   struct device_node *rproc_node,
> +				   phys_addr_t addr, u64 size)
> +{
> +	struct platform_device *rproc_pdev;
> +	struct iommu_domain *domain;
> +	int ret;
> +
> +	rproc_pdev = of_find_device_by_node(rproc_node);
> +	if (!rproc_pdev) {
> +		dev_err(rdev, "failed to find remoteproc platform device\n");
> +		return -ENODEV;
> +	}
> +
> +	domain = iommu_get_domain_for_dev(&rproc_pdev->dev);
> +	if (!domain) {
> +		put_device(&rproc_pdev->dev);
> +		dev_err(rdev, "no IOMMU domain for remoteproc\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = iommu_map(domain, addr, addr, size, IOMMU_READ | IOMMU_WRITE, GFP_KERNEL);
> +	if (ret)
> +		dev_err(rdev, "failed to map remote heap phys=0x%llx size=0x%llx err=%d\n",
> +			(u64)addr, size, ret);
> +
> +	put_device(&rproc_pdev->dev);
> +	return ret;
> +}
> +
> +static void fastrpc_remote_heap_unmap(struct rpmsg_device *rpdev,
> +				      phys_addr_t addr, u64 size)
> +{
> +	struct device_node *rproc_node;
> +	struct platform_device *rproc_pdev;
> +	struct iommu_domain *domain;
> +	size_t unmapped;
> +
> +	rproc_node = fastrpc_get_rproc_node(rpdev->dev.of_node);
> +	if (!rproc_node) {
> +		dev_warn(&rpdev->dev, "failed to find remoteproc node for heap unmap\n");
> +		return;
> +	}
> +
> +	rproc_pdev = of_find_device_by_node(rproc_node);
> +	of_node_put(rproc_node);
> +	if (!rproc_pdev) {
> +		dev_warn(&rpdev->dev, "failed to find remoteproc platform device for heap unmap\n");
> +		return;
> +	}
> +
> +	domain = iommu_get_domain_for_dev(&rproc_pdev->dev);
> +	if (!domain) {
> +		dev_warn(&rpdev->dev, "no IOMMU domain for remoteproc during heap unmap\n");
> +		put_device(&rproc_pdev->dev);
> +		return;
> +	}
> +
> +	unmapped = iommu_unmap(domain, addr, size);
> +	if (unmapped != size)
> +		dev_warn(&rpdev->dev, "partial/failed heap unmap: requested=0x%llx unmapped=0x%zx\n",
> +			 size, unmapped);
> +
> +	put_device(&rproc_pdev->dev);
> +}
> +
>  static int fastrpc_init_reserved_mem(struct fastrpc_channel_ctx *cctx,
>  				     struct device *rdev, u32 domain_id)
>  {
> +	struct device_node *rproc_node;
>  	struct resource res;
>  	u64 src_perms;
>  	int err;
> @@ -2536,6 +2620,19 @@ static int fastrpc_init_reserved_mem(struct fastrpc_channel_ctx *cctx,
>  	if (domain_id == ADSP_DOMAIN_ID) {
>  		cctx->remote_heap_addr = res.start;
>  		cctx->remote_heap_size = resource_size(&res);
> +
> +		rproc_node = fastrpc_get_rproc_node(rdev->of_node);
> +		if (rproc_node)
> +			cctx->use_iommu_map = of_property_present(rproc_node, "iommus");
> +
> +		if (cctx->use_iommu_map) {
> +			err = fastrpc_remote_heap_map(rdev, rproc_node, res.start,
> +						      resource_size(&res));
> +			of_node_put(rproc_node);
> +			return err;
> +		}
> +
> +		of_node_put(rproc_node);
>  	}
>  
>  	if (!cctx->vmcount)
> @@ -2611,7 +2708,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  		data->unsigned_support = false;
>  		err = fastrpc_device_register(rdev, data, secure_dsp, domain);
>  		if (err)
> -			goto err_free_data;
> +			goto err_unmap_heap;
>  		break;
>  	case CDSP_DOMAIN_ID:
>  	case GDSP_DOMAIN_ID:
> @@ -2619,7 +2716,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  		/* Create both device nodes so that we can allow both Signed and Unsigned PD */
>  		err = fastrpc_device_register(rdev, data, true, domain);
>  		if (err)
> -			goto err_free_data;
> +			goto err_unmap_heap;
>  
>  		err = fastrpc_device_register(rdev, data, false, domain);
>  		if (err)
> @@ -2627,7 +2724,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  		break;
>  	default:
>  		err = -EINVAL;
> -		goto err_free_data;
> +		goto err_unmap_heap;
>  	}
>  
>  	kref_init(&data->refcount);
> @@ -2655,6 +2752,11 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  	if (data->secure_fdevice)
>  		misc_deregister(&data->secure_fdevice->miscdev);
>  
> +err_unmap_heap:
> +	if (data->use_iommu_map && data->remote_heap_size)
> +		fastrpc_remote_heap_unmap(rpdev, data->remote_heap_addr,
> +					  data->remote_heap_size);
what about hyp-unassign in case of Gunyah?> +
>  err_free_data:
>  	kfree(data);
>  	return err;
> @@ -2695,24 +2797,29 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
>  	list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node)
>  		list_del(&buf->node);
>  
> -	if (cctx->remote_heap_size && cctx->vmcount) {
> -		u64 src_perms = 0;
> -		int err, i;
> -		struct qcom_scm_vmperm dst_perms;
> -
> -		for (i = 0; i < cctx->vmcount; i++)
> -			src_perms |= BIT(cctx->vmperms[i].vmid);
> -
> -		dst_perms.vmid = QCOM_SCM_VMID_HLOS;
> -		dst_perms.perm = QCOM_SCM_PERM_RWX;
> -
> -		err = qcom_scm_assign_mem(cctx->remote_heap_addr,
> -					  cctx->remote_heap_size, &src_perms,
> -					  &dst_perms, 1);
> -		if (err)
> -			dev_err(&rpdev->dev,
> -				"Failed to assign memory back to HLOS: addr %pa size %#llx err %d\n",
> -				&cctx->remote_heap_addr, cctx->remote_heap_size, err);
> +	if (cctx->remote_heap_size) {
> +		if (cctx->use_iommu_map) {
> +			fastrpc_remote_heap_unmap(rpdev, cctx->remote_heap_addr,
> +						  cctx->remote_heap_size);
> +		} else if (cctx->vmcount) {
> +			u64 src_perms = 0;
> +			int err, i;
> +			struct qcom_scm_vmperm dst_perms;
> +
> +			for (i = 0; i < cctx->vmcount; i++)
> +				src_perms |= BIT(cctx->vmperms[i].vmid);
> +
> +			dst_perms.vmid = QCOM_SCM_VMID_HLOS;
> +			dst_perms.perm = QCOM_SCM_PERM_RWX;
> +
> +			err = qcom_scm_assign_mem(cctx->remote_heap_addr,
> +						  cctx->remote_heap_size, &src_perms,
> +						  &dst_perms, 1);
> +			if (err)
> +				dev_err(&rpdev->dev,
> +					"Failed to assign memory back to HLOS: addr %pa size %#llx err %d\n",
> +					&cctx->remote_heap_addr, cctx->remote_heap_size, err);
> +		}
>  	}
try moving this block to helper function as same can be used in
fastrpc_rpmsg_probe() error case. Maybe something like this:

static void fastrpc_remote_heap_release(struct fastrpc_channel_ctx
					*cctx, struct rpmsg_device
					*rpdev)
{
	if (!cctx->remote_heap_size)
		return;
	if (cctx->use_iommu_map)
		fastrpc_remote_heap_unmap(rpdev, ...);
	else if (cctx->vmcount)
		fastrpc_remote_heap_unassign(cctx, rpdev);
}
>  
>  	of_platform_depopulate(&rpdev->dev);
> 
> ---
> base-commit: ef071c4906eb45d16b60f09154cf0bc6ec8f5435
> change-id: 20260930-fastrpc-kvm-iommu-v2-1a7d343ed802
> 
> Best regards,
> --  
> Anandu Krishnan E <anandu.e@oss.qualcomm.com>

