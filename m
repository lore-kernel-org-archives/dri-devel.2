Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8752606A323
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 07:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SCl53yVU;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=E3pYYLjs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04FCE10E763;
	Fri, 13 Nov 2026 07:43:50 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CF9F10E763
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 07:43:39 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AD5asq53147686
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 07:43:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qyhZym5r7vlLk7+pIInUS9OjK0AomV6NyXnFLTBOCfE=; b=SCl53yVU4J4+MSVT
 o/QDP6uNq8kCG/ql0UL3LtSIcnWyPYK+KAWt74V1jgvGn8bmso2b1RAf2so3Vvb7
 fCCCsQhmfwIpSYUjzKnDtYyE3AdrZ7M7SsLRlpHczmzuYuZuGxRz1sfVlHQpnuC/
 uQBJX6NW5fI8EauX6BLqazy9n26hyF77XhzDCRYoKcPQmwdkunU+vjCLXJ336U5L
 7Upkkt+AeMDJn7Jic2/v9Fs799F12tpieieJ9N0jdY175IcSzqsxJPLH1dPjStLH
 Sk4Lr+HwgzKcW6lDZnW4JiKQCncxur5yutvHh2bnXotDaR+AhtTlAlNV8Hji0ubM
 OQaTaA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwvja8d8d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 07:43:38 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-37549877380so916988eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 23:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794555818; x=1795160618;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qyhZym5r7vlLk7+pIInUS9OjK0AomV6NyXnFLTBOCfE=;
 b=E3pYYLjsE3l3b97XJRw1AsOGI1dT/dnTarQB+7/Ki3xxOA1yLYLSw4mKGJXUVoQyLa
 DWCv/RZrBp0jtR+rcP1ZhrnnM1/CUfkLdEWSShIPRIVWBf7b4eGX3moPdBa+IxNmi/2Q
 iYcosB9IQ1rHIqzSUaEB0mK/znvcXq/XQKtq3/KWW42s0ZpR8j49DCaxFkazRRIQKmTO
 wOoG2rBRQLgatsOMdh2M1GKvrqkVIVgBgVxVVl0HTMHTVfpdSY+1o1pPh2OpXKB7rtGJ
 47v6qSsb9JZNK8Szz1ry+xeZ7rLe5+IUNQa4q2da11AVAbuMBO4GHpRXSr8qFzjFRhLq
 4drQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794555818; x=1795160618;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qyhZym5r7vlLk7+pIInUS9OjK0AomV6NyXnFLTBOCfE=;
 b=RmVOPPzSR8pezUODaW+IqgH9u5Exa2O0OqW0RZhhZRmMpChQBSzQQuAlAzKdZ86CVI
 IB6GLLJI/LH7bsNMfOC6l701ZCcI1/XhM2LYh4hwpUTvxg4ctByyqeFX+lDhqTMo6FOG
 B5R7GTRRt/teb3PBCxiVeLd2mTC6YDLZesBn0AHloVOmtimUmdib0njYk+EltCvSlW2G
 O5YFunxF0n2+M/m3Y1SvvPAPZlAzuJ9nxK/D3HcLa/kBBQLX9wmpPUoxC1LgKW7Rq8oH
 Pbnjpf9qvjkwX3vCyXGF5Iy0TEdVUPgrMR0kp+t84huX1Iu0bz38CLcm6ozrfaHXm703
 BPIA==
X-Forwarded-Encrypted: i=1;
 AL+hErFW6sd/t/JdB8DoZ+ihXPbibBBYZ3zASlZ4b2w9LAbuwgpEoQOLolHzqETn9dreL8OBLKisuzhH92k=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z99FKrbZRNn36dCisTPJbSNuzHe8b4IipGx3b2n1JodL+GHITgY
 YqnrgTziSlpm3jRhw6y6XNl7VjgiK0mQNRggZQqGOQKaAjLcFCeWUodYDMZVirFSY1WF/cchWOL
 cAAzmeUqzbFuU32ENLdOoqq6HHA+I3iAGPd+CG3kJuTYmg7IAL6of26UJ6l6xnCFL1HZaDVo=
X-Gm-Gg: AYBFou1qS4vtCkQevY7SS2XvGyZYfDePsSOQrYDThHvgkAqlll0eXEDKjgizM0vZpqo
 rkLKvrzWtUT5YFthoEunEFCWOjjT0eQ2QV7ToXkAsa8Eg6COhSDSwmGcV6DORizziy8EPt86tRT
 t8/i9fd2oB3OCYZ9xfk61ikfmN/uB6F+s/BE17IaZJDlrr4GSGLfLBZdohcdbdH7mlY11L9L6Y4
 VswC6B6srpB0PgjYaCxwh2o7HcmgKyLBVKymDbnhoOpeyZFMm1sF3AlRKQxIDALp+mZ2aqSiVNx
 mxCTf3yCaQEJ6WndhUFRLr/cz9jJMfpUgkQSrw8naItPseJGS2BeT9FBWu5eXYg/Ld9qxKtf4Ic
 z9SA4NHW6YAT2MqDKKFqhRjn8hDs0bJ/9Kzp6uMy4G9KYDNtnyTCnfxC5rQj0uF//wa2C+8xuLz
 c=
X-Received: by 2002:a05:7300:b284:b0:35e:2c6:d46c with SMTP id
 5a478bee46e88-37966e3abf5mr1789745eec.10.1794555817347; 
 Thu, 12 Nov 2026 23:43:37 -0800 (PST)
X-Received: by 2002:a05:7300:b284:b0:35e:2c6:d46c with SMTP id
 5a478bee46e88-37966e3abf5mr1789720eec.10.1794555816714; 
 Thu, 12 Nov 2026 23:43:36 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37955822d58sm4641162eec.10.2026.11.12.23.43.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 23:43:36 -0800 (PST)
Date: Fri, 13 Nov 2026 13:13:31 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 4/8] media: venus: migrate firmware loading to
 qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
Message-ID: <20261113074331.4vkjhcqzu3vqpyt5@hu-mojha-hyd.qualcomm.com>
References: <20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com>
 <20260925155737.4161358-5-mukesh.ojha@oss.qualcomm.com>
 <20260926155935.250F71F000FF@smtp.kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260926155935.250F71F000FF@smtp.kernel.org>
X-Proofpoint-GUID: VNzOp0AA4sSngM3jcIN0gsP7VO7gmZ8S
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAzMCBTYWx0ZWRfXxgUNWNBRP4zX
 ZhyoiosnPM1F7YyvEyEryJjXQoA7tWv/m2qdb19y0x+T/paEFNyDKRFbyQYSlWdDgnHuS2O6FYJ
 jAYw3XAtStoY9fDgnUaL1Oe+YGEqLHI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAzMCBTYWx0ZWRfXyzvNA18mGrBl
 nsWeiJs4DCeWIlOc/lPl0O7PtSksjWHCTNkyBTlyVBL4IsYIW0IF6zwY6l79r9zPdD3z+JOCQ5D
 WL46z3QYQKZImWfRYDE8WBuTuK/MSUUY4mOAQYY62zIuruYgZ4IixNgXiQF+RcvGu7pC7BVTp4N
 KnNNXC+yYNz5/qHonqGdYU3Pk3iFVK/vGcr3Ray79DJ/3wVttUjWXP2/jnaGXfD8qhYQujpFk7y
 9m8n++ouJBqMz/sZo2d5cRygm1A6M/0Lrf+ybpHWRrUa45OHjsE6JL8XWuBt5e0fJw6Xa1P3mBD
 aW2EwL5BAMCAiCn95QG32ZU/RVjikkxwvxFRrnWjFn6WjEj1Tywwly09Rkr3NDaLVKsULifv2iF
 2hHzXzCJKxvAHt6rtj3q8TiZK5lWRb2SDIyibkhjitwxKGDWJh/yuOU6XgdDgxnJ/zPccFaDTlG
 081mVtTWhG76YO7LlDQ==
X-Proofpoint-ORIG-GUID: VNzOp0AA4sSngM3jcIN0gsP7VO7gmZ8S
X-Authority-Analysis: v=2.4 cv=AoN7T+9P c=1 sm=1 tr=0 ts=6af6bfaa cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=8nJEP1OIZ-IA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=Pjq1V1fNRajfxtsVpAsA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=scEy_gLbYbu1JhEsrz4S:22
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611130030
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Sep 26, 2026 at 03:59:34PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] media: venus: devm_ allocation in venus_load_fw() causes leak on error recovery
> --
> 
> commit 8d4223f26ac66cddad9e1923272c5c9297949631
> Author: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> 
> media: venus: migrate firmware loading to qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
> 
> This commit migrates the firmware loading for the TrustZone path to use the
> new PAS context allocation and loading functions. It threads the PAS context
> from venus_load_fw() through to venus_boot() where authentication occurs.
> 
> > diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> > index 3a38ff985822f..4ea4c7769ac3d 100644
> > --- a/drivers/media/platform/qcom/venus/firmware.c
> > +++ b/drivers/media/platform/qcom/venus/firmware.c
> 
> [ ... ]
> 
> > @@ -117,21 +116,19 @@ static int venus_load_fw(struct venus_core *core, const char *fwname,
> >  		goto err_release_fw;
> >  	}
> >  
> > -	mem_va = memremap(*mem_phys, *mem_size, MEMREMAP_WC);
> > -	if (!mem_va) {
> > -		dev_err(dev, "unable to map memory region %pa size %#zx\n", mem_phys, *mem_size);
> > -		ret = -ENOMEM;
> > -		goto err_release_fw;
> > -	}
> > -
> > -	if (core->use_tz)
> > -		ret = qcom_mdt_load(dev, mdt, fwname, VENUS_PAS_ID,
> > -				    mem_va, *mem_phys, *mem_size, NULL);
> > -	else
> > -		ret = qcom_mdt_load_no_init(dev, mdt, fwname, mem_va,
> > +	if (core->use_tz) {
> > +		core->fw.pas_ctx = devm_qcom_pas_context_alloc(dev, VENUS_PAS_ID,
> > +							       *mem_phys, *mem_size);
> 
> [Severity: High]
> Does this devm allocation leak memory during firmware error recovery?
> 
> Looking at the firmware recovery path, when a firmware crash occurs,
> venus_sys_error_handler() repeatedly invokes venus_boot(), which then calls
> venus_load_fw().
> 
> Because devm_qcom_pas_context_alloc() attaches the allocation to the device's
> lifecycle, it is only freed when the device is unbound. Each recovery cycle
> will allocate a new PAS context and overwrite core->fw.pas_ctx without freeing
> the previous one. This could lead to unbounded memory consumption and an OOM
> crash if an attacker or stream continuously triggers firmware crashes.


same as iris driver, placement of devm_qcom_pas_context_alloc()
need to be changed.

> 
> > +		if (IS_ERR(core->fw.pas_ctx)) {
> > +			ret = PTR_ERR(core->fw.pas_ctx);
> > +			core->fw.pas_ctx = NULL;
> > +			goto err_release_fw;
> > +		}
> > +		ret = qcom_mdt_pas_load(core->fw.pas_ctx, mdt, fwname, NULL);
> > +	} else {
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com?part=4

-- 
-Mukesh Ojha
