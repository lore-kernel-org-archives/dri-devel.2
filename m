Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459D2606A8AD
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 07:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Zdglxlsq;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CAB8bq4S
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7054E10EBC4;
	Fri, 13 Nov 2026 07:46:27 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD2CB10EBC4
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 07:46:15 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AD5thoE1756149
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 07:46:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=FMnFKA+4pMDyPqtDTHmVFfRA
 jC7IXzhIXpiggjzZ9YI=; b=ZdglxlsqS1jkrUVZb9JmJJu/zkcwdcocm1GCUFvn
 XB687YlqPWTLsVSHLzxBQbmQFHEwkZfbIOaVL2T1P0fLDLmnfDH7jAa2sDAemnoN
 pbUDelgRJlH8NKWpcbj1it7f4CWA4S+3I2PUK5AF/3bMfvzQVSMNGDMCyQR5uRMl
 X5o+WPBEmxp2QtwEzN6W5AbAgc6KJsU0ZBQkFaevjKjK2Rf4c5RAjUhEDlZ871bM
 iQy+K/ZS/xujAUgeBjNzFKsZx6/HUcTqKmHcfkcrendW+w4C167a1ocWhRTL3n5i
 RJ7aypU3H3r/5OC234slQhJbglJ+Bnw2QfasJ+fvdUeQ4g==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwvu6rbqn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 07:46:14 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-370230d93efso3220261eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 23:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794555973; x=1795160773;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FMnFKA+4pMDyPqtDTHmVFfRAjC7IXzhIXpiggjzZ9YI=;
 b=CAB8bq4SV/VUJUIGkwmDaBi/Tnm40Hsy4Ph5GpkO22k7zKuNwsFppftB4ropfa7UZL
 TJxLYRPFASNcXRo2q0M1Z2QFyjd247I360qWY3o07X/RRLlg4s0ZUH/20iD5yQed08B8
 6XiAGMNpLez8soU23LZDqmn22he7ZpdRyYYBuYeIkP0Vk+VwjgVtIcy8QVbHq2kXqzKi
 U6FWges82e76kK1Jw+wy6V6tdGnQQPzcI7kgGQaQwZ+8pLik+VOeRgsuVs5gha0Nilg+
 ybKWKlv4swP79RMN3nRhkj2h8zt1B/VcChpIzCiAEvv74qfXmIm9gIjZjeLkCGP0Fl2+
 uVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794555973; x=1795160773;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FMnFKA+4pMDyPqtDTHmVFfRAjC7IXzhIXpiggjzZ9YI=;
 b=AyVecerlE/0inoLDxwKh2fdCBvFypGfj6d9szqlSZ/BA9H7S3ByAW5fFz0rmSzlVw+
 vbWpEiH8gm72xp4Mo6Pm1nbGWINv+A8xrEc989jjMEF48ukJ57I2MymILf7LIZ3L4qu6
 hsSQuM9ryPw/KxyQEPVyEpIwcnR/J6guCSLOt7XgGZd9h5LjjzwPHnmMEUXvJz3hmTh3
 Vg3pxTYhdcF8J8BSV9vVZZp+kIbtro2837eg0VZVrbEymlvP6Z1JUhOhY9zoJcmvOoGD
 7O+JcDyGpVkUl1n8mv6oy+E9mI3LXzCLD9fkC0CK8sSVVtCImNgyMGt8eLrd0jG3f+Ig
 btMg==
X-Forwarded-Encrypted: i=1;
 AL+hErGY3Ey4+dKuTOMGNBHxdvnf+sqj9yZyVf7ltfcIObIl+TjzfXRYuhWmVPbEzZNzlk+aa3W9DrACidI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/W3GqK6+oQnwKDc4dc8rAFXxtdBL4bLUXiRsTOit+B1+4oGFCb
 WeApxVQT9bdK6cEAxCHGT8unXIfa+THNxpjrz6bYHi9cchfNILT+zCZ8OrNvN/Sec/D/iC/xHvM
 nYwkToj/LKFIz6IsrXsFKsVhfuUWMHSlbRjzloD/sNYRaXYSqLlS5wXdCnOY8Jx2YbuAj9dI=
X-Gm-Gg: AYBFou2mYEbh0d7BDWeaykbcUOXMVuJ3oFsIpJ/CaKpDwV3F6yHNx33eVmeFOXIj9Xg
 XEXB+yo/7VdU1nRcDzQDlIjnGUcuopVW02ZxZVz0Kj/sJpZ6WgSeg3qFewI3tGWIjbLePW5nU76
 Qd+2tCNGCvnkSnk/TM77AmT4jPM+SZoJYVt0z7MiX1aLrLnuatqhB8Z6QDkn2FsAZZBPOkl825q
 iTK5Y1/UvYHxAm171ks8qYyvqdvbmCr/YQzTJBMiw8y03vmfE0XqM56L3nL9d6yrpkDf7i/B3wm
 AmhCkCjhfooMW6/mQ63E5j4DVVCdQINfzSUqe8rFV1UZ/8QAzHQGkrPjhpXRdECTo8hAOssqnVF
 x5ztUla97sTAmhXaPhHrAmZVd1/1bVF2i+qYevVZnd2uy1cfCyDhd0VUXGHiYEsSi3wIcgMg3lm
 8Q
X-Received: by 2002:a05:7300:8812:b0:379:24d9:cb98 with SMTP id
 5a478bee46e88-3796048149dmr1954006eec.0.1794555973185; 
 Thu, 12 Nov 2026 23:46:13 -0800 (PST)
X-Received: by 2002:a05:7300:8812:b0:379:24d9:cb98 with SMTP id
 5a478bee46e88-3796048149dmr1953955eec.0.1794555972421; 
 Thu, 12 Nov 2026 23:46:12 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379560f5e06sm6281195eec.19.2026.11.12.23.46.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 23:46:12 -0800 (PST)
Date: Fri, 13 Nov 2026 13:15:58 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Gourav Kumar <gourav.kumar@oss.qualcomm.com>
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
Subject: Re: [PATCH 4/8] media: venus: migrate firmware loading to
 qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
Message-ID: <20261113074558.al5xktcizxfklkaz@hu-mojha-hyd.qualcomm.com>
References: <20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com>
 <20260925155737.4161358-5-mukesh.ojha@oss.qualcomm.com>
 <73bb47d6-af10-41d0-8fd2-173eadbaa937@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73bb47d6-af10-41d0-8fd2-173eadbaa937@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAzMCBTYWx0ZWRfX7NeoOJvJh41P
 rifJ9qZF8ef10eKOcTAZQI+FVvxX0yvd1FznME7VUxrklAIQJ7ERlVTLvR2PczwM19ibVGI0Oi8
 oZ/OnuepyZB5XfALn4mdsIA1pd28YIvkyouX/5pVzKXoxxzK6ZKwVPl1bTeyxwZ1U4gLVkJ4z+e
 1pUWXpK24+Wuva8Jk9ZB3nR5wXQk129UhwUinunBWwt6g0jMJoTggytgiL4HN/HdmdEL8tMTfC/
 wja3v8J9W22GuBaY4OqnyAERphVsDwshSACe9o3LtpGYwH6EkiJovg3tTveUnA5rJrveLCR8hdT
 z3gElp3IYxj22YeewSXtp8ei8/s2X2LeaK2CU15rYO8QobNmD6YQnxPrz1yb0PhDGrC8DVGYxoF
 Tt6915qTgLMqRiyHYC3bDWrJXrEYN+eR5Y499oitzxdePS6aKNIIUDP4S7BA8WnagfxOoemRg7b
 2AMX6OHsKq/w9frWVfQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAzMCBTYWx0ZWRfX5LhT0RiETljH
 X60Eo1NAPFLiySxAogZy4OStoTT2EpjrLitgVPxD74E8ohDv4Gp5OCPJsRDP8McAOW3RJzdm/l5
 qBnPo0tf7iA9SKR0WPPqlkwDwx9GhL8=
X-Proofpoint-GUID: cXrETHpNq6s2J1NRgDXmAj5pNxLalkxf
X-Proofpoint-ORIG-GUID: cXrETHpNq6s2J1NRgDXmAj5pNxLalkxf
X-Authority-Analysis: v=2.4 cv=JfcpPkKV c=1 sm=1 tr=0 ts=6af6c046 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=8RL4tSxfe4pX_uSLj0sA:9 a=CjuIK1q_8ugA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 03:05:14PM +0530, Gourav Kumar wrote:
> 
> 
> On 9/25/2026 9:27 PM, Mukesh Ojha wrote:
> > venus_load_fw() uses qcom_mdt_load() for the TZ path and a bare
> > memremap()/qcom_mdt_load_no_init()/memunmap() sequence for the non-TZ
> > path.  venus_boot() then calls qcom_pas_auth_and_reset() which skips the
> > shmbridge prepare step required before TrustZone authentication.
> > 
> > For the TZ path, add a pas_ctx pointer to struct video_firmware so the
> > context can be threaded from venus_load_fw() where it is allocated to
> > venus_boot() where authentication happens.  Replace qcom_mdt_load() with
> > devm_qcom_pas_context_alloc() and qcom_mdt_pas_load(), storing the
> > context in core->fw.pas_ctx, then pass it to
> > qcom_pas_prepare_and_auth_reset() in venus_boot().
> > 
> > For the non-TZ path, pass NULL to qcom_mdt_load_no_init() directly,
> > removing the explicit memremap()/memunmap() since qcom_mdt_load_no_init()
> > handles the mapping internally when mem_region is NULL.
> 
> That is only true after patch 7/8, which adds the NULL mem_region
> handling to qcom_mdt_load_no_init(). Until then a NULL mem_region is
> rejected, so the !use_tz path fails between patches 4 and 7, which
> breaks bisection. I would suggest rearranging/splitting the patches so
> the qcom_mdt_load_no_init() change comes before this one.
> 
> Gourav Kumar
> > 
> > Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> > ---
> >  drivers/media/platform/qcom/venus/core.h     |  2 ++
> >  drivers/media/platform/qcom/venus/firmware.c | 29 +++++++++-----------
> >  2 files changed, 15 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> > index 46705a666776..adcf67043bf6 100644
> > --- a/drivers/media/platform/qcom/venus/core.h
> > +++ b/drivers/media/platform/qcom/venus/core.h
> > @@ -9,6 +9,7 @@
> >  
> >  #include <linux/bitops.h>
> >  #include <linux/list.h>
> > +#include <linux/firmware/qcom/qcom_pas.h>
> >  #include <media/videobuf2-v4l2.h>
> >  #include <media/v4l2-ctrls.h>
> >  #include <media/v4l2-device.h>
> > @@ -223,6 +224,7 @@ struct venus_core {
> >  		size_t mapped_mem_size;
> >  		phys_addr_t mem_phys;
> >  		size_t mem_size;
> > +		struct qcom_pas_context *pas_ctx;
> >  	} fw;
> >  	struct mutex lock;
> >  	struct list_head instances;
> > diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> > index 3a38ff985822..4ea4c7769ac3 100644
> > --- a/drivers/media/platform/qcom/venus/firmware.c
> > +++ b/drivers/media/platform/qcom/venus/firmware.c
> > @@ -86,7 +86,6 @@ static int venus_load_fw(struct venus_core *core, const char *fwname,
> >  	struct resource res;
> >  	struct device *dev;
> >  	ssize_t fw_size;
> > -	void *mem_va;
> >  	int ret;
> >  
> >  	*mem_phys = 0;
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
> > +		if (IS_ERR(core->fw.pas_ctx)) {
> > +			ret = PTR_ERR(core->fw.pas_ctx);
> > +			core->fw.pas_ctx = NULL;
> > +			goto err_release_fw;
> > +		}
> > +		ret = qcom_mdt_pas_load(core->fw.pas_ctx, mdt, fwname, NULL);
> 
> qcom_mdt_pas_load() passes the ctx to qcom_pas_init_image(), which keeps
> the metadata buffer in ctx->ptr, and qcom_pas_prepare_and_auth_reset()
> does not free it. Who is expected to call qcom_pas_metadata_release()
> for venus?

I already replied in the other thread; it is taken care of with below
change, as clients like venus and iris do not need to call
qcom_pas_metadata_release() since the default value keep_mdt_buf is set to
false for every client that is not interested in saving the context
pointer.

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=2aa8fafc08e777e9da356307c1a0117e7f4277cf

> 
> Gourav Kumar
> 
> > +	} else {
> > +		ret = qcom_mdt_load_no_init(dev, mdt, fwname, NULL,
> >  					    *mem_phys, *mem_size, NULL);
> > -
> > -	memunmap(mem_va);
> > +	}
> >  err_release_fw:
> >  	release_firmware(mdt);
> >  	return ret;
> > @@ -237,7 +234,7 @@ int venus_boot(struct venus_core *core)
> >  	core->fw.mem_phys = mem_phys;
> >  
> >  	if (core->use_tz)
> > -		ret = qcom_pas_auth_and_reset(VENUS_PAS_ID);
> > +		ret = qcom_pas_prepare_and_auth_reset(core->fw.pas_ctx);
> 
> ctx->use_tzmem is not set for venus, so the shmbridge creation in
> qcom_scm_pas_prepare_and_auth_reset() is skipped and the behaviour is
> the same as the old qcom_pas_auth_and_reset(). Please reword the commit
> message accordingly, since it currently implies that the prepare step is
> now performed by the new API as a fix.

Sure.

> 
> Gourav Kumar
> 
> >  	else
> >  		ret = venus_boot_no_tz(core, mem_phys, mem_size);
> >  
> 

-- 
-Mukesh Ojha
