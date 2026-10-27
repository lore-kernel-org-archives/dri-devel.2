Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C8B606A338
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CRCBryhV;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=M4qnSEAi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EC5310F345;
	Tue, 27 Oct 2026 09:35:39 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BB7210F35F
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 09:35:28 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R8gKXP1162740
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 09:35:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 j6yPMDXi4fS6KQ3576nZY/OVApnfprcl/P19fLe4qcQ=; b=CRCBryhVSiz9hmn5
 WNjNIF0n6TsVPZRkGrzm6EgWdxYT7/8pSIbWs2MmHL5eVGe7f3RrA1i+2A1iXtT+
 jnplF4qHhSttPzkVc1nbpv6zktC5x0aP4awSTl57EgUAXQqckxqpy5r6jJFRnK67
 oZHOqgJH5ldqBLDkgLeceO81PvGGtH8BZBJrg/u3ICRol6RErVKqjn+r7UnJ4ocg
 rmAXBJ8zamLt27pTzeWsaeem127fcw5cwehjYUItzJjSq8eCR1aziuxH13bmCxtD
 6+yW5CAAL3oPPNQX+qQI/Si4SrM7UUp/jkPyEf8gDmhvY0YW5wnDujIamsCgtBWS
 1FGT/w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjbmmax5a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 09:35:27 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2e869e00005so64111975ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 02:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793093727; x=1793698527;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=j6yPMDXi4fS6KQ3576nZY/OVApnfprcl/P19fLe4qcQ=;
 b=M4qnSEAirCPzYQUr4fnUwf2JlQZhSUnrmVBTuez3QpnrzJM3ESmto8m3djkBmy5ji/
 eDqI/FkZnxebvutl1k2oaS7szhot+xG+qxKwRgOjko3igZhy/+PtFP48i2JacXts4nxp
 uBs6YP/uFP3QEDPZDsedRQxFLagmdv9LyIEVyCF1ET2t/NV55AOfeTGNwGTkVdibO9RC
 D07H1l7Sb4XufAEvYyjqPIJQkXxEckqEEqHH5hQrOs+w6Zu+4LLvf+EflSB9p1nGSmX/
 aZeBugbOG5+aJAGlDOvHe86UFkL2ssulbYwUNXB+wZ9CMjaS9xTNesbnhVlb1z99ZyBA
 fhlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793093727; x=1793698527;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j6yPMDXi4fS6KQ3576nZY/OVApnfprcl/P19fLe4qcQ=;
 b=xUJ+dWZ71bYnfrzl4MYQRFa7XhiPQM+71y08GtscK2a6t77liVVK8y3RhkPJu5Tzo7
 AIH9P3bvulZL5Ob+vRypRxHMvEn/mviu0Q2MzrkHonwguSeyFtmU4gDRbomvBd0uK841
 ECkIcKRM9qB+/Rh9jxdyigLfjrWhtyKCfp+iQbQm2nFuQ+aqcHIH+m0HyWtdYctfXeaS
 wrj+zNEiz2vw7RR8M5HhiifSm/+T1bjYM5+vWB3Q+a3VXHS/t37afIn1C214qtPAeu83
 EnIsh7hjX4toFL/f5f4MNRYBY85Z4VG6S3vg6eK8W6csyg3mQdgJYUYozAvKVDTXM4KH
 UpYA==
X-Forwarded-Encrypted: i=1;
 AKwUvByZy0D+NrSAGTwk5TsxzPguAynoxn4AKOiFi6qGospsW4P3nmd+1dDVftBPV6qPgoVn9gzrEaaIEHo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL4g5RgAySSeSF5395F2nHBFxWoSVoM7iDqJjlPBybPTifwbeG9
 817S7LQNdo38U89G1/kL/zkv0bVTUf5DVTK8EQHF5X6Cnw+hs586h/w5WHjCv4O+rfzyiHOsSmp
 4mtLBw6KdAbtIgfZUj+ie78LTlrHaDRdvxzJeaYIMdqyMpudbQA6Fz3F6firik+u8l/rK8hY=
X-Gm-Gg: AYBFou2Au+n/a1KyQIsPoIH1h9sNKUQzcWbr9eX01DvPNTq44DURWvjD9aUFpdACKNa
 Xg8qY8F7rGo3SLmtQ/KkvdUcojVcQAo8bO/vLNmV/3xw2o6yZSHx5oxUpYe6/A5MBm/+JtAiMsj
 ZvbPl7rrBRDS8s4N1J2a88ikKXVMMLs3pM03A64PiJngovbA8YqPIQCrETEoAB8FwYzlRKahHMr
 4JSkn+tRS/EbG2BpSbnXaH4uvO2TJTEve6IObDveFMDY/6x2TeOk78OQLjZ0bLwJodiCS9Fdj2d
 nFwFFyc31uUEWbc20ll/xPowbC4HTDxMR2cHIc9dPCxolCmtEZOERiL5jmlPEwtF21QvxN5xKb8
 ecMRKIwlMUlQpVxiCTRX91vMG23ni0wc=
X-Received: by 2002:a17:903:1a4e:b0:2e8:7686:4d46 with SMTP id
 d9443c01a7336-2ea9c7fa255mr70643165ad.34.1793093727094; 
 Tue, 27 Oct 2026 02:35:27 -0700 (PDT)
X-Received: by 2002:a17:903:1a4e:b0:2e8:7686:4d46 with SMTP id
 d9443c01a7336-2ea9c7fa255mr70642895ad.34.1793093726553; 
 Tue, 27 Oct 2026 02:35:26 -0700 (PDT)
Received: from [10.204.101.238] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eae6b7a216sm6260945ad.16.2026.10.27.02.35.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 02:35:26 -0700 (PDT)
Message-ID: <73bb47d6-af10-41d0-8fd2-173eadbaa937@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 15:05:14 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] media: venus: migrate firmware loading to
 qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Bryan O'Donoghue <bod@kernel.org>, Mauro Carvalho Chehab
 <mchehab@kernel.org>,
 Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jeff Johnson <jjohnson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Abel Vesa <abelvesa@kernel.org>, Sean Paul <sean@poorly.run>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org
References: <20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com>
 <20260925155737.4161358-5-mukesh.ojha@oss.qualcomm.com>
Content-Language: en-US
From: Gourav Kumar <gourav.kumar@oss.qualcomm.com>
In-Reply-To: <20260925155737.4161358-5-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAzOCBTYWx0ZWRfX5AXFmqTCN9/e
 /6Qp+HLG/wbFJfx90Y91cCKuPIvKz+GYd0zhF/PpkAHFq2y9lMXhbU+QgYE5qr8Fn+HLpldE4OU
 O/RgRNJjhB+aIimqNZqyeGfVkDpk+aI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAzOCBTYWx0ZWRfX6RogS24++mdY
 7j3iRJ7+o4Ys0hyJB91FXMxHL5k9oK3bJMVfGLO4dKUIaRb7nEZ4EchoZYz66DgDiK5JKX9TS0U
 4jxcuWTQLm2fa94BIL4JbjB6DT70HlmOo3us7uR27+fcagJwm3UqaB5Jzp/o0QxLcUc7RKNWGRX
 1Tp4XLemBIpKi/ZHE1gogPfS5/fEpoWCMhnWs86FrV98yBFDw8WolvTowj7g/5/T3tJnPp8wvOy
 xzhMcw1qoIfMbbWtfI5+d8QnuHydlgrrQcJDPKexeL1TQ6kTqH9j3ForjN7FtU3PnX5UvPNcsPg
 D+YXGbMD+NJwru3D9AH96A6+t4yBX5XQeGFUA9NOVYbIaaWLETRnvT7eN78KOAYVY39E3eQq7v/
 vOT5JYmma7lu9ySfm/5Uc3v/DistaeNqyqzr4pReDma75DJOL3ogbiHdI5aD5n6E7PRSuCsU3ze
 Qx9nab9SqczYk9bMJPA==
X-Authority-Analysis: v=2.4 cv=PrkG/AM3 c=1 sm=1 tr=0 ts=6ae0705f cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=qKw8xLqAnBtdxZYI7koA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: K5f_g13nNHE7Tk0gAbTtzwv_NpLVKMVb
X-Proofpoint-GUID: K5f_g13nNHE7Tk0gAbTtzwv_NpLVKMVb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 impostorscore=0 clxscore=1011 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270038
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 9/25/2026 9:27 PM, Mukesh Ojha wrote:
> venus_load_fw() uses qcom_mdt_load() for the TZ path and a bare
> memremap()/qcom_mdt_load_no_init()/memunmap() sequence for the non-TZ
> path.  venus_boot() then calls qcom_pas_auth_and_reset() which skips the
> shmbridge prepare step required before TrustZone authentication.
> 
> For the TZ path, add a pas_ctx pointer to struct video_firmware so the
> context can be threaded from venus_load_fw() where it is allocated to
> venus_boot() where authentication happens.  Replace qcom_mdt_load() with
> devm_qcom_pas_context_alloc() and qcom_mdt_pas_load(), storing the
> context in core->fw.pas_ctx, then pass it to
> qcom_pas_prepare_and_auth_reset() in venus_boot().
> 
> For the non-TZ path, pass NULL to qcom_mdt_load_no_init() directly,
> removing the explicit memremap()/memunmap() since qcom_mdt_load_no_init()
> handles the mapping internally when mem_region is NULL.

That is only true after patch 7/8, which adds the NULL mem_region
handling to qcom_mdt_load_no_init(). Until then a NULL mem_region is
rejected, so the !use_tz path fails between patches 4 and 7, which
breaks bisection. I would suggest rearranging/splitting the patches so
the qcom_mdt_load_no_init() change comes before this one.

Gourav Kumar
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/venus/core.h     |  2 ++
>  drivers/media/platform/qcom/venus/firmware.c | 29 +++++++++-----------
>  2 files changed, 15 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> index 46705a666776..adcf67043bf6 100644
> --- a/drivers/media/platform/qcom/venus/core.h
> +++ b/drivers/media/platform/qcom/venus/core.h
> @@ -9,6 +9,7 @@
>  
>  #include <linux/bitops.h>
>  #include <linux/list.h>
> +#include <linux/firmware/qcom/qcom_pas.h>
>  #include <media/videobuf2-v4l2.h>
>  #include <media/v4l2-ctrls.h>
>  #include <media/v4l2-device.h>
> @@ -223,6 +224,7 @@ struct venus_core {
>  		size_t mapped_mem_size;
>  		phys_addr_t mem_phys;
>  		size_t mem_size;
> +		struct qcom_pas_context *pas_ctx;
>  	} fw;
>  	struct mutex lock;
>  	struct list_head instances;
> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> index 3a38ff985822..4ea4c7769ac3 100644
> --- a/drivers/media/platform/qcom/venus/firmware.c
> +++ b/drivers/media/platform/qcom/venus/firmware.c
> @@ -86,7 +86,6 @@ static int venus_load_fw(struct venus_core *core, const char *fwname,
>  	struct resource res;
>  	struct device *dev;
>  	ssize_t fw_size;
> -	void *mem_va;
>  	int ret;
>  
>  	*mem_phys = 0;
> @@ -117,21 +116,19 @@ static int venus_load_fw(struct venus_core *core, const char *fwname,
>  		goto err_release_fw;
>  	}
>  
> -	mem_va = memremap(*mem_phys, *mem_size, MEMREMAP_WC);
> -	if (!mem_va) {
> -		dev_err(dev, "unable to map memory region %pa size %#zx\n", mem_phys, *mem_size);
> -		ret = -ENOMEM;
> -		goto err_release_fw;
> -	}
> -
> -	if (core->use_tz)
> -		ret = qcom_mdt_load(dev, mdt, fwname, VENUS_PAS_ID,
> -				    mem_va, *mem_phys, *mem_size, NULL);
> -	else
> -		ret = qcom_mdt_load_no_init(dev, mdt, fwname, mem_va,
> +	if (core->use_tz) {
> +		core->fw.pas_ctx = devm_qcom_pas_context_alloc(dev, VENUS_PAS_ID,
> +							       *mem_phys, *mem_size);
> +		if (IS_ERR(core->fw.pas_ctx)) {
> +			ret = PTR_ERR(core->fw.pas_ctx);
> +			core->fw.pas_ctx = NULL;
> +			goto err_release_fw;
> +		}
> +		ret = qcom_mdt_pas_load(core->fw.pas_ctx, mdt, fwname, NULL);

qcom_mdt_pas_load() passes the ctx to qcom_pas_init_image(), which keeps
the metadata buffer in ctx->ptr, and qcom_pas_prepare_and_auth_reset()
does not free it. Who is expected to call qcom_pas_metadata_release()
for venus?

Gourav Kumar

> +	} else {
> +		ret = qcom_mdt_load_no_init(dev, mdt, fwname, NULL,
>  					    *mem_phys, *mem_size, NULL);
> -
> -	memunmap(mem_va);
> +	}
>  err_release_fw:
>  	release_firmware(mdt);
>  	return ret;
> @@ -237,7 +234,7 @@ int venus_boot(struct venus_core *core)
>  	core->fw.mem_phys = mem_phys;
>  
>  	if (core->use_tz)
> -		ret = qcom_pas_auth_and_reset(VENUS_PAS_ID);
> +		ret = qcom_pas_prepare_and_auth_reset(core->fw.pas_ctx);

ctx->use_tzmem is not set for venus, so the shmbridge creation in
qcom_scm_pas_prepare_and_auth_reset() is skipped and the behaviour is
the same as the old qcom_pas_auth_and_reset(). Please reword the commit
message accordingly, since it currently implies that the prepare step is
now performed by the new API as a fix.

Gourav Kumar

>  	else
>  		ret = venus_boot_no_tz(core, mem_phys, mem_size);
>  

