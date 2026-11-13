Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230DB606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 07:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QzBFYHuM;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DBw1PIC/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BE7710E76F;
	Fri, 13 Nov 2026 07:36:04 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E38AA10E3E3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 07:35:52 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AD573OF367270
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 07:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 W08ynuNH2qpl4faB48VJWBnQidu6XrNwK+C0td19Bwo=; b=QzBFYHuMLa7wUI/j
 NCrA2NODtnYThMoE0JyZP3zAq1HOYCYgfMdJPdfFoRG8hTfdCu+THipb73zmwAjF
 BEeNfBygSBVVy54H7K9rUQLQwT0V5XuZLQWAy2i94ABhtyt1mKsNNIG0dTQ5B1s3
 irOkGdOS+910SGmbZWuGUTqCPzyNlrRvL6sec1Ql8FtedJX0Xq0EyCc2Xve1c6Mp
 gqct6jdgdTlgMzdrVjak0yTbb/fYNA9hbC+Tz3teCMGMRsMucLqLjSLekeb9Dk4m
 vmOHa78aHeMtenaVrwT7gzxDl5STjIbbSI2m+34efd1TxJR1lan15mQtbWu8Lz6+
 b2M/uQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwbx342am-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 07:35:52 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-37549877380so909239eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 23:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794555352; x=1795160152;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=W08ynuNH2qpl4faB48VJWBnQidu6XrNwK+C0td19Bwo=;
 b=DBw1PIC/UKAJbWFX7fzRtXrp5r1GtZgvnlnXoksDnCvtTvLnaeIojwz5JCAkfO2gSg
 QaQ8ROHdN9LgJuSzo65mewaqD/wBKSKceeojXS+Em7BIY3pk7BQMOXoNj7hWXlXlEUix
 GWvt0o/7IGHOSakr8NYpCpIrD+UdteMS/tHWYOTz0oa11AbCuK84ZrNcdZWQEzxwybfN
 PJjuuoZrRKVnXiWiv65hDnCEdf0xu1xkRWBzSzdZxJPKQjnGpzTeOouJfELZNmaIJMV/
 c5GfMCA1rxl9FVcO0HFOM+HxPPi7GPU/P9uDTmvRgiR+mwtVzsqGrKghvtQms4086tVC
 4Vmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794555352; x=1795160152;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=W08ynuNH2qpl4faB48VJWBnQidu6XrNwK+C0td19Bwo=;
 b=ky4ujxJbGpT3MKSU4XSBxCaWbJGVFzxYs9d0bAMbe8PO80AzxxGQs5pXkIZ/AXxfq7
 DPBmUgCyFaUGRlpwbW0TBhEtuoNclRH4C+903ZexoNL/DPd/0HruObCNt9z3Ke/SR2M5
 ozNByicljNvSnpX1vGW5AoniBic4Nf/oWRw5QrAFx7qKLBD7zB0libOL/mgMlCGLcnXc
 gxOsljjkZmDjEp28xwKEvrvsxrBrXXpO88sQf/INT92CckQXQqhmlLKVX/el68G9DIOv
 I1qJuR/SN/c4JOkR2jyA+hOoGX/OlY6n8gYyh1po6DkQ0KwzPpiZOrvq1K3qidipdTrE
 GJdw==
X-Gm-Message-State: APuU4Z8DaTXn4axcaRBWjXnrMFpUZMww3drkhMIZYi0WE7IEFL2wpiqi
 lbKwms2zXLSIZOHb5U3x20tButtyVEfmca8erIeRWISIOgwFJNQWkb03IPxltE/Jaro45m99qkl
 ifKvsRNHqnvpvTxR3H6ryw91hwZzBlnlA867ugXN2sDzVaCrOGDGhhLyq7gmvI992Ajfhs12VCD
 xhLRQ=
X-Gm-Gg: AYBFou3Q3kWkRaYH7OKxPsz8DowoYasijmAbugsxNIlAFBrMaXp4S2Av+MoITyyoovs
 JHr/zU3aeZchr3sF8OgXB+rMTqFkLO3bYyFkpEH9aYPPutc8AewfJV+vye/UumbYc96iKvvKuHC
 dccFhNnHNzSmw8NZD46Gt0VVLuMLL4wXO4jl3kG/tBzq6ayjgGp5MUJcSrkTOYVb42n5um/DbXu
 OHcpHIfJ2PeVDK5MImxn4vbnTRkhdJpXkD9R2w2o2hctJ6NhIX/nk6+ucjKbcIU0xeaad8g8NC1
 tkwNcaKcoOa1PrFKlppE3uCbYPcXGLKAbscDsxoitq+9x2/5TAsPrLqHc1EnIwu6+HiR96470bP
 IjNKzHVIpjk7oJHj8Jyu5lU3wPF+/7jdRXf8R7/HhnG0XhJUPG9+uXqfUGjQtB6KzWWdbzSlATe
 0=
X-Received: by 2002:a05:7300:cc9c:b0:371:5cb0:4929 with SMTP id
 5a478bee46e88-37967dd4c20mr1514773eec.25.1794555351334; 
 Thu, 12 Nov 2026 23:35:51 -0800 (PST)
X-Received: by 2002:a05:7300:cc9c:b0:371:5cb0:4929 with SMTP id
 5a478bee46e88-37967dd4c20mr1514753eec.25.1794555350669; 
 Thu, 12 Nov 2026 23:35:50 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37955e0d966sm4960626eec.15.2026.11.12.23.35.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 23:35:50 -0800 (PST)
Date: Fri, 13 Nov 2026 13:05:45 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
Subject: Re: [PATCH 2/8] drm/msm/adreno: migrate zap shader loading to
 qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
Message-ID: <20261113073545.5wktaqlnon6yajcs@hu-mojha-hyd.qualcomm.com>
References: <20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com>
 <20260925155737.4161358-3-mukesh.ojha@oss.qualcomm.com>
 <20260926155936.8DE5D1F000FF@smtp.kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260926155936.8DE5D1F000FF@smtp.kernel.org>
X-Authority-Analysis: v=2.4 cv=S+5MU4sP c=1 sm=1 tr=0 ts=6af6bdd8 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=8nJEP1OIZ-IA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8 a=CW2y-Ud1XA8kvYtVx5EA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAzMCBTYWx0ZWRfX6tJZeaxqUGtm
 /xn6A4kBmWgCC9TIvzoYlVv0fvEAXDtvI9Hp07d4gpkDcP5Rxc2g0s0i0nZ3op9lk1uhs6GEAew
 R2wNEDnNqlr0CRin/v5ZavUFDH6kDSijoauQNeUi/+LYdaEXzAAbbIukKHa+VbqfQFH31WPA9CO
 Tl338271HStt/TRMZ5mV7ouefipta0gWF4uxmJPk4oJspNjS23rGc1dg6Y0GtDOxpxyCiiwa39T
 FUmN2p05nR4QXHb13uc9EwnEH4A/yla0bsZSsUr4Od2FADsGMys8tOL+ezqap08dRB1asVZZIIi
 FF886TCjNvNepST0Q2KfJaNe91Yltxb21205z71GdkvWL1nKV1eKjxPqPF1HL+LUG3wlw1V2vgp
 QUtmtk+NcrTlvn9IkYceSrfv5a4M6qKE1iDIEJmDPV6hx97SiYPETh+0ujz28zc/A+9Jz+q33z8
 NRq49Q9GxxiiONjyvLQ==
X-Proofpoint-ORIG-GUID: etnYkmQNjrJR3OqzTrbLwkRlPW7Ghb7X
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAzMCBTYWx0ZWRfX0as26zb1VrDu
 9WeviMpcd5TOCcVIhWpbMLUksRnLYOCIRqg1T/qn6gUVEBoKpGov6+lnOmUp2HNDWRZuTyW8kfT
 KL80UeTlepy7s+r7D0HAgkYFZ195mUA=
X-Proofpoint-GUID: etnYkmQNjrJR3OqzTrbLwkRlPW7Ghb7X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
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

On Sat, Sep 26, 2026 at 03:59:36PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] drm/msm/adreno: memory leak of PAS metadata buffer
> - [High] drm/msm/adreno: shmbridge preparation step silently skipped
> - [Medium] drm/msm/adreno: struct qcom_pas_context leaked via devres on post-probe retries
> --
> 
> commit 4d137953382eb8839541fc9229948a9472d95133
> Author: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> 
> drm/msm/adreno: migrate zap shader loading to qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
> 
> This commit replaces the open-coded memremap/mdt_load sequence for zap shader
> loading with devm_qcom_pas_context_alloc and qcom_mdt_pas_load. It then passes
> the context to qcom_pas_prepare_and_auth_reset to ensure the shmbridge
> preparation step is executed before TrustZone authentication.
> 
> > diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> 
> [ ... ]
> 
> > @@ -122,9 +122,9 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname,
> >  	}
> >  
> >  	/* Allocate memory for the firmware image */
> > -	mem_region = memremap(mem_phys, mem_size,  MEMREMAP_WC);
> > -	if (!mem_region) {
> > -		ret = -ENOMEM;
> > +	ctx = devm_qcom_pas_context_alloc(dev, pasid, mem_phys, resource_size(&r));
> > +	if (IS_ERR(ctx)) {
> > +		ret = PTR_ERR(ctx);
> 
> [Severity: High]
> Is the shmbridge preparation step actually skipped here?

yes.

> 
> The commit message mentions fixing the omission of the shmbridge prepare step.
> However, devm_qcom_pas_context_alloc() uses devm_kzalloc() which zeroes the
> context, and ctx->use_tzmem is never explicitly set to true in
> zap_shader_load_mdt().
> 
> Because of this, it looks like qcom_pas_prepare_and_auth_reset() will hit
> the early return (if (!ctx->use_tzmem)) downstream and bypass the shmbridge
> creation entirely, leaving the behaviour unchanged.
> 

That's expected.


> [Severity: Medium]
> Can this devm allocation cause an accumulating memory leak during post-probe 
> retries?
> 
> Since devm_qcom_pas_context_alloc() ties the allocation to the device
> lifetime, if zap_shader_load_mdt() fails and is called multiple times during
> runtime PM resume or GPU recovery sequences, the context allocations might
> accumulate without being freed since the device remains bound.


May be I need to find proper place for
devm_qcom_pas_context_alloc().

> 
> >  		goto out;
> >  	}
> >  
> 
> [ ... ]
> 
> > @@ -165,9 +163,6 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname,
> >  		DRM_DEV_ERROR(dev, "Unable to authorize the image\n");
> >  
> >  out:
> > -	if (mem_region)
> > -		memunmap(mem_region);
> > -
> >  	release_firmware(fw);
> >  
> >  	return ret;
> 
> [Severity: High]
> Does this exit path leak the PAS metadata buffer?
> 
> When qcom_mdt_pas_load() executes, it internally calls qcom_pas_init_image(),
> which allocates a metadata buffer and stores it in ctx->ptr. Unlike the
> previous flow with a NULL context where the buffer was immediately freed
> internally, a valid context tracks it so the caller can free it.
> 
> Should there be a call to qcom_pas_metadata_release(ctx) in this exit path
> to prevent leaking this physical memory on every execution?


Same as earlier, buffer will be free'd immediately after below
change . So, no leak for the buffer.
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=2aa8fafc08e777e9da356307c1a0117e7f4277cf

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com?part=2

-- 
-Mukesh Ojha
