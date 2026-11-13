Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1C5606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 07:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fiOotXiP;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=S5rbX1rm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EFC210E3E3;
	Fri, 13 Nov 2026 07:39:47 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9405310E3E3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 07:39:35 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AD56wwU2618537
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 07:39:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8dQubeiySwp0kQI+mmdG+WIY7hmszt1niI8//v/h0yY=; b=fiOotXiPqQBXd2/n
 orpm30WVRtQ6Z0MwVagdoemvl1COtqj2n1ymivekPAGEfBV7uYNWzUHcA0gr7QOV
 /Mk1hoBKMONHttX+MvUSgVh4o9hhC180lJakIX4BcSKl4KpM2cdl3LSm72mFepOe
 I68KGG8uvdbULrYJyiLrws+mzsYnBH1bHhPq+b9Xq5lkINKlEy+ystNDwL7HBN11
 xWNZ3AU0QA0m9tBa7iU9sXndm5KD/4vRqnymZhXChsd2wQbuPnAiOjeqF7pAkSib
 rZllWFEwYFYQQZwcZl5k6liXxmnhfNU/ITen/t9F/9wYlwwQpEvL032uMbcYP28d
 d3KhLA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwu2mrqud-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 07:39:34 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-154e9d2d94fso1966418c88.0
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 23:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794555574; x=1795160374;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8dQubeiySwp0kQI+mmdG+WIY7hmszt1niI8//v/h0yY=;
 b=S5rbX1rmNX9HkTWK/rL+e2l0S9jlnTRe1dHVQgCi6Y+snQIkXMpx3OjQFa0B6iE2V3
 +ItcDXIKW+we6KO7bHIrfvihqbsKDc5dM7upNzkqU0IXHre56HJxB2BoAZG9rcWfvdvu
 yj336aei8Azzx1xZQXemlklyvI/AxVEqwL+KV5mt0fmbHyLnbTENBSsPJa4GVNkZZfj4
 svnXLRPT0log1As/r6jh2aGlD7eI3aYEjySBqcNwcPV9xenfLU5qttLut45DORjSybix
 iq6cIIExyXiM1/xcQCb446cl484qNedQQMDLe7spkmiSGGBLhpYoABXp6RjuGHlHOhNp
 d05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794555574; x=1795160374;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8dQubeiySwp0kQI+mmdG+WIY7hmszt1niI8//v/h0yY=;
 b=NWuKAMYye+/CC5NtjRPfsPqDzXi8awmcHl0rTNn87zJSmmk86XNzzLzWynXcSNrIVW
 TVIDdty3+LxcIbW1LRwGh1BjqJpcmjOj3O7mpt1BlDXyS6Sd6khwfCf/PVCTbJen8x1i
 bVXozsh+1ETE9cF4/1zBdqvMZ9F4+7A4Z2fuMJ5S3b9TVWQeas3+5f/EOby83iOYvdXO
 qtMs9DzRFE5bZO08Mk53+k65H1Bq8IHL20dH7ZredzKieladt205JaSr8agc+Cd8mD9U
 uvMimPtJhGJINKFN6wJdx4E6Zl5JexUDUmABsXvn6y00Txn9QeXqgoSlSFNr7VJ3omv1
 pI4w==
X-Gm-Message-State: APuU4Z8T6BGJJjv/I6bQhb3GZqsTZD9rFo51CVyT9c8LkAlvsgYwZ2Jm
 fGkZnyvZcVKITpdM3/9rV9Z4SlBCOMqfNATjtI38TfkOdp6LSjMcK9mjlDIOZSvEs5tvbb87i/v
 RbwxlXOljq50tfKAg64i8NTZC0Qa0ePGOBPI71k1fWCkad7cPlLxnF+5/4X3hnA4Ir1Q7jQ1/k6
 O6IjA=
X-Gm-Gg: AYBFou0JJP1UAQUQ3JJUxWDMtOWeYAQKd+fqUsmaW8fRKfvkeogauZpp07wwr0ejzxl
 vp9K7B4wvf4V8m6mlckv+Ne3Tqacwk47OPYi60V08XkAAS6gWpc9s33xoF86VaY9wBkkJ7VE3m3
 Z9ZDVZWKbd387iQooDBzL14XUgFT1ffmkyo7UIbYLmWttg29/IYDKHgk8StQnCXOWekJxcAbHGl
 WLYNyrr0HaNuDKoM3sPBmmS6bTiPNKlaBiTC9xYkrO/AOfzUVs5ISOjkwUiwrUyl9ORQnkcgkEs
 mUxbOlWHMZT3/xINawmBEvLwD94cWQfhkuy98BU5E/vK2BOFrZY9KJFMfGDm63GudnnBMXnBgmc
 5UprLl2lZhp/Dd0ohWgHi0pIP9/+k7Oudujdnx1M56+Ntf69OSzFaGijL19Gf/n/r/zKdMuFA8W
 Tt
X-Received: by 2002:a05:701b:454a:20b0:194:3a84:e67a with SMTP id
 a92af1059eb24-1b503146625mr2003723c88.41.1794555573891; 
 Thu, 12 Nov 2026 23:39:33 -0800 (PST)
X-Received: by 2002:a05:701b:454a:20b0:194:3a84:e67a with SMTP id
 a92af1059eb24-1b503146625mr2003693c88.41.1794555573106; 
 Thu, 12 Nov 2026 23:39:33 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5031bc518sm4776197c88.15.2026.11.12.23.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 23:39:32 -0800 (PST)
Date: Fri, 13 Nov 2026 13:09:27 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
Subject: Re: [PATCH 3/8] media: iris: migrate firmware loading to
 qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
Message-ID: <20261113073927.6lmwcqjlj4h7xr3r@hu-mojha-hyd.qualcomm.com>
References: <20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com>
 <20260925155737.4161358-4-mukesh.ojha@oss.qualcomm.com>
 <20260926155935.D7FDD1F000FF@smtp.kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260926155935.D7FDD1F000FF@smtp.kernel.org>
X-Proofpoint-ORIG-GUID: 8W0ZtHcMUZ3rLjhRoqnAfHFhqVmRlL2O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAzMCBTYWx0ZWRfX4VjA6tqIoa3H
 0CYj6adSxqLB2xyaoNZcsF13aJXmRY3dT+Wwb+xKueefjQODP5s+dE/uGGYbAOzeJKM5HucBlxi
 7us+xSa3fnNYusYuiZ1CsCMxhD2GldNRPOlCWvTx9ZNoWa3GoswW/O/w1LhdcLjHU7edLQwvsFi
 0WBvcDpTrSACHiBxpz6f5FeLgDrjMudzus9dAPR8hYAv8nBQMGpdw+PFLlK0r30iVTOx+xKrnLS
 HWKfgymahA8BCWTQZ/tRL2JdvaGhVfK6BJ/ir8YtHvQ+/AtLslzaumB1QG0LlJhHy2TBWulZqtA
 4l62Cn9Kl76/DVdEhlq1gdjiC00AkZNraj5SbowCSFhh6tRxbz+Uf9eHITu2hbqb0sEX7ErWoJk
 c7Bgq5gpZMcUsqPDq+2eIHHXn6PTZSFhDbkjzESMEOxJnmwTCgbvqm02UxP7RiBtd8/1axHrAEL
 7TSHg37KibiWuzao63Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAzMCBTYWx0ZWRfX/D63Ta+Og22i
 xI/51vAPBy7lsXVpCCtzNif1vi2dxwIxF65eJPGta6C4Wr6FTxhM/9NUDRsCet65W5YGtK9rSpA
 4Fx7l4k4whnxvFC3+qKbCfqLaLMDQgQ=
X-Authority-Analysis: v=2.4 cv=ddQVTnXe c=1 sm=1 tr=0 ts=6af6beb6 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=8nJEP1OIZ-IA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8 a=MUQbuDeSX6FSj05hh9YA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=vr4QvYf-bLy2KjpDp97w:22
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: 8W0ZtHcMUZ3rLjhRoqnAfHFhqVmRlL2O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130030
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Sep 26, 2026 at 03:59:35PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] firmware: qcom: pas: missing qcom_pas_metadata_release() leaks TZ/DMA memory
> - [Medium] devres: memory leak due to repeated devm_qcom_pas_context_alloc() on fw reload
> --
> 
> commit bb3acb8beaa539b1cfa0975914c1f8fd75747e36
> Author: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> 
> media: iris: migrate firmware loading to qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
> 
> iris_load_fw_to_memory() calls qcom_mdt_load() which bundles metadata
> init, memory setup, and segment loading with no PAS context, and
> iris_fw_load() calls qcom_pas_auth_and_reset() which skips the shmbridge
> prepare step required before TrustZone authentication.
> 
> > diff --git a/drivers/media/platform/qcom/iris/iris_firmware.c b/drivers/media/platform/qcom/iris/iris_firmware.c
> > index 21cdf1c398357..e73a5dd98b88c 100644
> > --- a/drivers/media/platform/qcom/iris/iris_firmware.c
> > +++ b/drivers/media/platform/qcom/iris/iris_firmware.c
> [ ... ]
> > @@ -134,21 +131,20 @@ static int iris_load_fw_to_memory(struct iris_core *core)
> >  	core->iris_firmware_data = core->iris_firmware_desc->firmware_data;
> >  
> >  	fw_size = qcom_mdt_get_size(firmware);
> > -	if (fw_size < 0 || res_size < (size_t)fw_size) {
> > +	if (fw_size < 0 || resource_size(&res) < (size_t)fw_size) {
> >  		ret = -EINVAL;
> >  		goto err_release_fw;
> >  	}
> >  
> > -	mem_virt = memremap(mem_phys, res_size, MEMREMAP_WC);
> > -	if (!mem_virt) {
> > -		ret = -ENOMEM;
> > +	core->pas_ctx = devm_qcom_pas_context_alloc(dev, IRIS_PAS_ID, mem_phys,
> > +						    resource_size(&res));
> 
> [Severity: Medium]
> Will this leak device-managed memory when firmware is reloaded?
> 
> If the hardware system error recovery path is triggered (for example,
> iris_sys_error_handler() calls iris_core_deinit() followed by
> iris_core_init() and iris_fw_load()), devm_qcom_pas_context_alloc() is called
> again unconditionally. This overwrites core->pas_ctx without freeing the old
> devres allocation.

Need to find proper place for devm_qcom_pas_context_alloc().. 

> 
> > +	if (IS_ERR(core->pas_ctx)) {
> > +		ret = PTR_ERR(core->pas_ctx);
> > +		core->pas_ctx = NULL;
> >  		goto err_release_fw;
> >  	}
> >  
> > -	ret = qcom_mdt_load(dev, firmware, fw_name,
> > -			    IRIS_PAS_ID, mem_virt, mem_phys, res_size, NULL);
> > -
> > -	memunmap(mem_virt);
> > +	ret = qcom_mdt_pas_load(core->pas_ctx, firmware, fw_name, NULL);
> 
> [Severity: High]
> Does this sequence leak DMA or TrustZone memory buffers allocated for firmware
> metadata?
> 
> When qcom_mdt_pas_load() is called, the underlying PAS subsystem allocates a
> DMA buffer for the metadata and stores it in the PAS context. The PAS API
> contract dictates that callers must subsequently call
> qcom_pas_metadata_release(core->pas_ctx) to free this memory.
> 
> Looking at iris_fw_load(), this step appears to be completely omitted on both
> success and error paths before the function returns. Because the DMA
> allocation is tied to the SCM device (not devres-managed for the iris
> driver), repeated firmware loads due to probe/unbind cycles or hardware
> errors could permanently exhaust restricted DMA or secure memory pools.

After this
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=2aa8fafc08e777e9da356307c1a0117e7f4277cf
the buffer is freed immediately in the call to qcom_mdt_pas_load(), similar
to earlier behavior.

> 
> >  err_release_fw:
> >  	release_firmware(firmware);
> >  
> > @@ -166,7 +162,7 @@ int iris_fw_load(struct iris_core *core)
> >  		return ret;
> >  	}
> >  
> > -	ret = qcom_pas_auth_and_reset(IRIS_PAS_ID);
> > +	ret = qcom_pas_prepare_and_auth_reset(core->pas_ctx);
> >  	if (ret)  {
> >  		dev_err(core->dev, "auth and reset failed: %d\n", ret);
> >  		return ret;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com?part=3

-- 
-Mukesh Ojha
