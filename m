Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09226606A334
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=F0QAN3oS;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Bx14gjrd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65D0910EC26;
	Fri, 13 Nov 2026 08:59:24 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60C2110EC18
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:59:13 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AD8VAuH3827298
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:59:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=JaCKuWoch5k2Kjk0XZXFM0Ps
 5nVvPhDt20xb/z6BgX0=; b=F0QAN3oSkmjXryB+McqTbr0iaQSPYlX2D23jMe7h
 tH3o7lIq0mdVAPS+NNwkMN/su6sThmzr5sTC6xO9v7mkZyvnbXjnxvw9stqfpXcu
 WX4z5RJ5SGXcBNzRjGxmp0W1VsWwkmDBOxKfLXPQ0TvbWSdmdMBxrXS5a5OvVClV
 m7R7GRaNqMoybnGaLWBKUlTU7aNy7HdZcr+xdL5tSAFNF0aNjCZxUDFtX2IDTEAi
 0bKR0qlla5OEvln95ah2olXoL9ZIPNnFq8By72s0o1qbkSNbIssU6OyCnUZ3GIqO
 z+pk7uXuVDRoBN+peJP481m6eCkso7A2PyYW5L4Z4faLpw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwv37gtgr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:59:12 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-378722fd4a3so885558eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 00:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794560351; x=1795165151;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JaCKuWoch5k2Kjk0XZXFM0Ps5nVvPhDt20xb/z6BgX0=;
 b=Bx14gjrdX+bdXQ0c3RO9n1ZEW4+ibsW+YA64CziPOqK3XuMNMKwx5hTALpK/fVYzsL
 bPHShcCnm9Rrpx7JG0daXFVTO0InEnA+/WrN6zZdVM0l5bP/tTDinAKIBz0CUu0iA/5t
 Lqcw3rL81JeXnFuoXcwEFfpQu/vvgUbu8OMU0+8Y7AMqRtowSuaJsW5j5C0HbTfkCDlq
 /wKRYD/fsBnucmlPL2NIT+u2L0pe3mFebQfXG+Qrf6YWHfTn173VNWt81V/uI+hqvwVY
 9aF4MnCSsuMORjonCB0toE6RzkKfNjzk+TlXNi3bIqHa28gUNZ6FR9xPypt1Tn2YJTWF
 fF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794560351; x=1795165151;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JaCKuWoch5k2Kjk0XZXFM0Ps5nVvPhDt20xb/z6BgX0=;
 b=IVAfwp9w/qny03YvJB0/NLIJgj4QXFcKGOZDXw7kyurL9cBlJSFbN9/OcsmPVDzDuh
 UDmA+Z4IVPTcziZ6Ni86FH5a3UA+rTHxpeZc4JJSEPBq6l4WAy69V41Q9Msp9UI+e2gf
 rMnHXbYv9H0Bj8JoAZIbNXOsFmDs5swgxsFt0myMPsw66aAZZ4PnSpCZFWez32t7tCQ0
 xy+ff8GIwxUEH5ypWdgmLujj0fdOxhP0nUTVIc2JA1q0h4lIeEE9MtP3j7NyIKlFjIrA
 5mz8CY8vzb0wn+mGZv8IVLCm5opiZcRkq/QwXOQCUb3QG12ncjlza79udqLH9CadJOd4
 VSHw==
X-Forwarded-Encrypted: i=1;
 AL+hErHj7OF5Rx95APzI86wPl9l+KVyuGJQIgz8rXowVvkrwMSTbnmjJe4jF4dIghMoj1IGXL5WVydY4w2E=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/7diGmu0zJMOyM1Et/vXljne0VjkshkoHBOQCsyxknX7wIA+04
 NWRcTac3augSvGUu/FAunTKa/+LN+Cn8ZUO283j52eHRMBgXSMJzKAeE9IJyN8/O3Zq9KxTG4JB
 bJh5IATE7+ZRjNEYUbs6oQMRgn2ferYNdCv81qaAAKcvMb9YUk4JiZMrgRwqu+atY+fTUCWw=
X-Gm-Gg: AYBFou1ZqBhc3S+zJ/GnWLmY0Sf/69xQZNpeza7v+ZwyyKryNQLJ8mpaEgBbJz6ktqX
 vRpraAVQhe89RUTjAxbfK5x9QvdO50X/2kkxQ9PR1Xs0ettVCqB+hq489IOJ2ipKmBqXc6Zo5vx
 FZwBymuBj8Cq8YZn2Ko6gWtce3ogOkn5S2o1ZFC5ogYqpAO52HeCp4WgGKpT2ujL/rZ33RBO+ZG
 EMsQ1RjKUf/VcwBBnBGb/wt9KAIu9MJQLrSc8XIAweHyTlufi6FDLKMeiArtD3PNWT1i+LoXcbq
 WfKQS08sPt4r5G11i9Bv+2R/Q1gC8raB7jHwTL8k5Cz/D8NftawWGYzPDsmYJPBpwPQCj+7O673
 Ig6UKAZ0ZtnAGA7sci9BuzxOyz5N9ZGlB30PUb85YQ1hMwdg+qbsLbANjxIKL6OS0cUMf1uAak3
 I=
X-Received: by 2002:a05:701b:261c:b0:18d:5988:8d3 with SMTP id
 a92af1059eb24-1b5030684d9mr1933680c88.3.1794560350794; 
 Fri, 13 Nov 2026 00:59:10 -0800 (PST)
X-Received: by 2002:a05:701b:261c:b0:18d:5988:8d3 with SMTP id
 a92af1059eb24-1b5030684d9mr1933628c88.3.1794560350098; 
 Fri, 13 Nov 2026 00:59:10 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b50313d8f5sm8926890c88.3.2026.11.13.00.59.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 00:59:09 -0800 (PST)
Date: Fri, 13 Nov 2026 14:28:56 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Alex Elder <elder@ieee.org>
Cc: Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Bryan O'Donoghue <bod@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jeff Johnson <jjohnson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Abel Vesa <abelvesa@kernel.org>, Sean Paul <sean@poorly.run>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 5/8] net: ipa: migrate firmware loading to
 qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
Message-ID: <20261113085856.mpa2zi4argm2e6y3@hu-mojha-hyd.qualcomm.com>
References: <20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com>
 <20260925155737.4161358-6-mukesh.ojha@oss.qualcomm.com>
 <ccf0300c-80e8-41a5-a394-6ec55fddc913@ieee.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccf0300c-80e8-41a5-a394-6ec55fddc913@ieee.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAzNSBTYWx0ZWRfXxv5c+y9ELvgN
 IpSVuq2e0bpLAzBO4A35P9qkBUJ8+xVi4AggB79B4p54OTS5cHzLzgy8JzGDI5by/mhE5l8F90n
 KP1UjMDfwpkiUFUxVDwbQxGOElVGdp0=
X-Proofpoint-ORIG-GUID: 8E6xyngIwDW3A1JR2DtYcAIgfzkap6b_
X-Proofpoint-GUID: 8E6xyngIwDW3A1JR2DtYcAIgfzkap6b_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAzNSBTYWx0ZWRfXxa41AooITWYD
 n9OZTR+HjJegFmfvplB3CTgzgSe8XDat50DW7F+TA3c8c7sH54lC2qw9UaMPnaG8nFWMERET2cx
 7OrVM0NszY0Wv35QGFAvjB0AknJ6hXxRGLByqJtYf+b+KUhWfidWHtNwhZzIZCsuJ9VxKxkkYjs
 ukvwqQW9Qat7cKgduXVXkAJ0338JH6xkK8Kh9FrKJipnkg0cD3gYXGUlaPfBTraeNP5488Yw/fy
 v20fYZfqSQn2FPYDIyuLpJuacVzfn0Q6F7rx8D99mRzDPwh9XZIqP4EL1l3J4okO5RTdaqX+jcg
 diEaR4SCMOQBh3U7UMjYBxQMhGZzmaDlfxsKJrdcrReyOthri+G1UY23n7lA7sn6PqlZb3Yi6/3
 QgJcPpdUjQxPfGrla/WuyqTxGbIFYNZMBriX0s0rJNT1t6wAUOcopl0Z56hQgWCUvW6aGTBQ7OP
 bniW/MJKs3uSH2pb2IA==
X-Authority-Analysis: v=2.4 cv=ZeeIpcVA c=1 sm=1 tr=0 ts=6af6d160 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=ee_2aqc6AAAA:8 a=s4fcayaxKqd7nPnH_LgA:9 a=CjuIK1q_8ugA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=VOpmJXOdbJOWo2YY3GeN:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611130035
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 07:49:03AM -0500, Alex Elder wrote:
> On 9/25/26 10:57 AM, Mukesh Ojha wrote:
> > ipa_firmware_load() calls qcom_mdt_load() which bundles metadata init,
> > memory setup, and segment loading with no PAS context, then calls
> > qcom_pas_auth_and_reset() which skips the shmbridge prepare step required
> > before TrustZone authentication.
> > 
> > Replace the open-coded memremap()/qcom_mdt_load()/memunmap() sequence
> > with devm_qcom_pas_context_alloc() and qcom_mdt_pas_load(), then pass
> > the same context to qcom_pas_prepare_and_auth_reset().
> > 
> > Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> 
> I think this does the right thing, however the IPA driver does
> not use resource-managed (devm) interfaces, and this would be
> a first.
> 
> Why does "qcom_pas.c" not offer an interface that can be used
> without devm_kzalloc()?  What if someone wanted to pass in a
> preallocated structure to be initialized with the (publicly
> defined) PAS context?
> 
> I was going to suggest that you just rework the code to use
> gotos and the cleanup path as used everywhere else in this
> driver, but it looks like that's not easy.
> 
> I'm willing to ack this but I would have preferred to preserve
> consistency.

Ok, let me fix this by introducing a new API to initialize the context,
which will only initialize and not allocate. This will also fix the leak
problem if the earlier API is called multiple times.

> 
> Reluctantly:
> 
> Acked-by: Alex Elder <elder@riscstar.com>
> 
> 
> > ---
> >   drivers/net/ipa/ipa_main.c | 24 +++++++++++-------------
> >   1 file changed, 11 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
> > index 14ac2d2faf7c..6964395caedd 100644
> > --- a/drivers/net/ipa/ipa_main.c
> > +++ b/drivers/net/ipa/ipa_main.c
> > @@ -585,12 +585,11 @@ static void ipa_deconfig(struct ipa *ipa)
> >   static int ipa_firmware_load(struct device *dev)
> >   {
> > +	struct qcom_pas_context *ctx;
> >   	const struct firmware *fw;
> >   	struct resource res;
> >   	phys_addr_t phys;
> >   	const char *path;
> > -	ssize_t size;
> > -	void *virt;
> >   	int ret;
> >   	ret = of_reserved_mem_region_to_resource(dev->of_node, 0, &res);
> > @@ -615,24 +614,23 @@ static int ipa_firmware_load(struct device *dev)
> >   	}
> >   	phys = res.start;
> > -	size = (size_t)resource_size(&res);
> > -	virt = memremap(phys, size, MEMREMAP_WC);
> > -	if (!virt) {
> > -		dev_err(dev, "unable to remap firmware memory\n");
> > -		ret = -ENOMEM;
> > +	ctx = devm_qcom_pas_context_alloc(dev, IPA_PAS_ID, phys,
> > +					  resource_size(&res));
> > +	if (IS_ERR(ctx)) {
> > +		ret = PTR_ERR(ctx);
> >   		goto out_release_firmware;
> >   	}
> > -	ret = qcom_mdt_load(dev, fw, path, IPA_PAS_ID, virt, phys, size, NULL);
> > +	ret = qcom_mdt_pas_load(ctx, fw, path, NULL);
> >   	if (ret) {
> >   		dev_err(dev, "error %d loading \"%s\"\n", ret, path);
> > -	} else {
> > -		ret = qcom_pas_auth_and_reset(IPA_PAS_ID);
> > -		if (ret)
> > -			dev_err(dev, "error %d authenticating \"%s\"\n", ret, path);
> > +		goto out_release_firmware;
> >   	}
> > -	memunmap(virt);
> > +	ret = qcom_pas_prepare_and_auth_reset(ctx);
> > +	if (ret)
> > +		dev_err(dev, "error %d authenticating \"%s\"\n", ret, path);
> > +
> >   out_release_firmware:
> >   	release_firmware(fw);
> 

-- 
-Mukesh Ojha
