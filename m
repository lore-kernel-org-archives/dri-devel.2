Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C264606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 13:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nTu8Rody
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06E6810EC84;
	Tue, 24 Nov 2026 13:12:42 +0000 (UTC)
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84B0910EC84
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 13:12:35 +0000 (UTC)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-1b5786e099cso2310692c88.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 05:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795525955; x=1796130755; darn=lists.freedesktop.org;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LS00jFvr9PC3GhAzX4jYHWKxPE6OoS0tT2nH27Ds460=;
 b=nTu8RodyPd+evAHgovM9Dv2GPlNgiN0L20rZxNWkIksvGC7v7k8v0fIQSGTNh1o+Uw
 UppSlS4/Ygdnk6wDnxlDFqzLnmqVd1eQq43A2sM5UTE4VZWsDdJYyRG/C26+FJlWGiUa
 pR1mzUWzvwxnGbW43CaI+qIR07tkNgs/mBj7wm7M1L3sxp8iG7FD2fE5crcNQBrki0pl
 c8miUoBxcDBZuI8/eVTD76azgLLAxnYRFY1AXGIGLjRq/T8foyaSyD53lI4arBfu+cik
 emPvz0uWkNIvKlUK6u1OTyCpyBra4gmJi8TdALbsDkazISSiFQq4UYnm0cygUVW9D/T/
 P45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795525955; x=1796130755;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LS00jFvr9PC3GhAzX4jYHWKxPE6OoS0tT2nH27Ds460=;
 b=kRaBy4rJTyQHjWPj3cHBRzuWXeK2a1riLaNMcx7H2MoM+zvfjSHjlNTRk2zPEx+P5/
 UHzkoW7b5gYWsetbkq3f+o2vbyGojpDLhNtP2JDKtxKFvIykstPx3ijN8vnXGFBdid8B
 QEtbzPqEkaMlvU34TZ+PBjrp0EUM2anFNNWg1eaaNl369/y4mUICvro4WOK24rC09ceR
 fePF5zRxSWvm7e8Br0/zvD0jC87Udf0pBU5UF4yQJoajwThChcZrlGgHPhn1453FR7GH
 oayn5f3yUwN8zI6oqvsvWXICfFdOcHvkwWh1YjU6ZHqHMTnEkq737ZCgcTbhuv7i8s8G
 6x7g==
X-Forwarded-Encrypted: i=1;
 AL+hErHEPla1QvOwC97GSWUBZ+U5GCgTLA3MCwFJV04FfWp+uk9PuPeQEnj8Ef0F9g63bqom4gXtt+Shqmg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9Fo9UCU6GiHegmNPYyp7Ici6RZgNEEpvUzmacGlKSgqM3pJBHw
 ZcpWXSBDKMDVzYc1/zUF/X40mgqDIuxSkUgDHsCRJ6tYQuBHIE4YxJN3AVbQx1Ew
X-Gm-Gg: AZFdTZeplOAo3ukgcyQsQqlyNn5amdYSCCeVFZ0y4YYrVtSlRqjntEm6h7FvSjMCgx3
 6riRh7gNCOHnYUG/15dUJ9hnFR+dBwDrRf7tJ28eE5KkXxht1K1C/zneUMI6pe5L64SnhlX97x7
 aMSNcOV5X0ASHLxzGuorphtVv4//pFDJV2B3Yp5lw+WYNbHyY1asdjv2BE+0voLbyfIdkYtMYy7
 ROS1kxFxyDU7r+31RF8sCqqikKIicb1kKx3Ix+wpvssVUkCsRoBc44CtSZrgQ4pt0nFDqSFnBIY
 3u8RsmtVykhNIW3skTDX8lnTJKEZTu4wPAwhoZYA+qgEiNmqkc5ePYuOVku+rQ5HYBE8wMa10YA
 JHxRf+Z37vf2pnUuHSkauXRe4pCDnDVMZKUM3bCddG/gqyLCP3jeMovFdolxiRjSORGh26nvQZu
 dCNLJQaEwvqy4ieAEvyjAdLd0vfqErcA08klYV+UZsJ7p1zuDhg+fkJPO+V5m3eJkmglZOil8SC
 jcfJYJAVnX4iEmAPZ0ZVu/rov5sBfqfGgaPieQhOqVaPSEFxQwu/ZgHQqeiJzNvRQRxC59eW6uE
 5bEhwhItQXeNkhgQX3hFr95KtuUd/SA5HK4zC4pMyQHV+xXP2X0drUc0Yf8=
X-Received: by 2002:a05:701b:42d4:20b0:1b5:43d8:b82a with SMTP id
 a92af1059eb24-1b55689e7b7mr14691957c88.9.1795525954542; 
 Tue, 24 Nov 2026 05:12:34 -0800 (PST)
Received: from [192.168.29.85] ([2405:201:8026:213e:1412:77ad:61f2:79f2])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b55682d301sm35659682c88.10.2026.11.24.05.12.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 05:12:34 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] drm/amd/display: fix USR retraining support check
From: mdshahid03@gmail.com
To: mdshahid03@gmail.com
Cc: austin.zheng@amd.com, jun.lei@amd.com, harry.wentland@amd.com, 
 sunpeng.li@amd.com, siqueira@igalia.com, alexander.deucher@amd.com, 
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <179433297650.153576.17456786292064820559.b4-reply@b4>
References: <20261101104727.141852-1-mdshahid03@gmail.com>
 <179433297650.153576.17456786292064820559.b4-reply@b4>
Date: Tue, 24 Nov 2026 18:42:13 +0530
Message-Id: <179552593350.187453.11405172136554803760.b4-reply@b4>
X-Mailer: b4 0.16.0
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
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Could you please check this patch and give feedback.When time permits.

Thanks
Shahid.

On 2026-11-10 23:19 +0530, mdshahid03@gmail.com wrote:
> Hi ,
> 
> could you please review this patch and give your feedback ,when time
> permits.
> 
> Thanks
> Shahid.
> 
> On 2026-11-01 16:17 +0530, mdshahid03@gmail.com wrote:
> > From: Mohammad Shahid <mdshahid03@gmail.com>
> > 
> > The USR retraining support check tests the address of
> > USRRetrainingSupport[j] instead of its Boolean value.
> > 
> > Since the address of the array element is non-NULL,the
> > condition can always true, even when USR retraining is
> > required but not supported.
> > 
> > This issue is reported by script test_addr.cocci.
> > 
> > Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_util.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_util.c b/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_util.c
> > index a8519f547dce..74cb65687a50 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_util.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_util.c
> > @@ -412,7 +412,7 @@ void dml_print_mode_support(struct display_mode_lib_st *mode_lib, dml_uint_t j)
> >  	dml_print("DML: MODE SUPPORT:     Host VM or Immediate Flip Supported        : %s\n", ((mode_lib->ms.cache_display_cfg.plane.HostVMEnable == false && !mode_lib->scratch.dml_core_mode_support_locals.ImmediateFlipRequiredFinal) || mode_lib->ms.support.ImmediateFlipSupportedForState[j]) ? "Supported" : "NOT Supported");
> >  	dml_print("DML: MODE SUPPORT:     dram clock change support                  : %s\n", mode_lib->scratch.dml_core_mode_support_locals.dram_clock_change_support == true ? "Supported" : "NOT Supported");
> >  	dml_print("DML: MODE SUPPORT:     f_clock change support                     : %s\n", mode_lib->scratch.dml_core_mode_support_locals.f_clock_change_support == true ? "Supported" : "NOT Supported");
> > -	dml_print("DML: MODE SUPPORT:     USR Retraining Support                     : %s\n", (!mode_lib->ms.policy.USRRetrainingRequiredFinal || &mode_lib->ms.support.USRRetrainingSupport[j]) ? "Supported" : "NOT Supported");
> > +	dml_print("DML: MODE SUPPORT:     USR Retraining Support                     : %s\n", (!mode_lib->ms.policy.USRRetrainingRequiredFinal || mode_lib->ms.support.USRRetrainingSupport[j]) ? "Supported" : "NOT Supported");
> >  	dml_print("DML: MODE SUPPORT: ===============================================\n");
> >  }
> >  
> > -- 
> > 2.43.0
> > 
> > 
> > 
> 
> 
> 
> 


