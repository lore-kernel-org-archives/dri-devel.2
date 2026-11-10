Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC39606A32E
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 17:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lWsz5DIP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F7F710E043;
	Tue, 10 Nov 2026 17:50:14 +0000 (UTC)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com
 [209.85.210.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3F7010E043
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 17:50:07 +0000 (UTC)
Received: by mail-ot1-f45.google.com with SMTP id
 46e09a7af769-843cf077f10so2832489a34.1
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 09:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794333007; x=1794937807; darn=lists.freedesktop.org;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BMHxxjO7SmiwuH9OUCwU1zX9un2r5kjXJMRK8QfbbXQ=;
 b=lWsz5DIPpbeB5D2JFptxS7lpDee6dq78QZv9UHNPNNQx5aShcZhllL+cOOzfBicvt+
 lpgBMwincZErstGFSle0a0V0L7qzIPGsKPJd1dCD2za8r8YtGi/hNYddfPLoH5Toe3X5
 B+6mqqO5eHN148/MO3bseRYoEO2viPHB7Nla3t3AGYKOqTsh28laBL4WVbuuj4NfULpd
 qjkkuvYT7z2axX5MhtvgM9Aaz6z6rHILdsgypAnGlO3EaxxgRnu2bxSThuYZIg3SwmYL
 WdTHIHB6PVCDDkByiWzu48wOpX4GV6o1ztAfpVTrjS2Dn9qA1pCAa7yzSQVlonTvB1vq
 Q4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794333007; x=1794937807;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BMHxxjO7SmiwuH9OUCwU1zX9un2r5kjXJMRK8QfbbXQ=;
 b=oZ3yMlVfHd2Nx/BlF+xfxe+2YmelKzd+qkXzRk2NmDMFhLbpA9iSPhbypbAvVhCUYn
 /1CuQTaDbb2IZJoIjCHKy6pSGi6YwjtuM5biREfhb0S+tfZp/XkuRnf9Xe6qaKMnueHn
 DWG3XPexgI1rPOnD8Et+Gg2oQtBSTx7HMius8CDoGX+/Zd76qzUDXkM6MIapBPNzjZrS
 poxTPCLXiZzHACu9yyYW8JalAZtWu4A/6v3yL5tSyMmwlhVzZ+s6MR4gkji6jeEKkncB
 q6LODZkF53lTt4vCtGOOCUADc+nKXttxBGrqtC3cVgUOlO4dFlPvpEBDYggAavuv4myO
 /Z2g==
X-Forwarded-Encrypted: i=1;
 AL+hErFhwsz2gFc2w+lo/pJwPa3WTrD1EdJWcMtl9zYDfn843SYpY58VOMHQHif4f0YVRdVaAwJ2GBDODPc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9tq42P7J0jmYPE5cMPJzw9pybImS51PL0sRpJUIXH5HbsDmPAU
 L/IFw7DPoX4phnfJ+YzEV0plAcqt+mp9WD6H35NGiadyamhFalPLrLzgVr/8yj1B
X-Gm-Gg: AYBFou0CK1vY90tPWjAjVfz/LQLXMJO1qyimRFUfgpFOmu29XmJ4p1yIThXkremaSoO
 Gs6HbLp0y6IPCa+oB8mP0GUu9Iyg9hJT4zJoBJcWc2JNDiXbzq4JhUhFVRzs7oBgJl+x2oU2HI5
 dF3/D3NuY0EHoqrKI7WcPu/j/v0HVwLGK4CQUk5cdYHKodjiiKU+5ZdLT4CVS2td7qWtMcHCgz4
 xrSoDeocVLjL0IB8l187/SY6ZZoRWpJEXFJWMh5f14z8BFTh0BSCQLHUOEHrVJ6Ua1jQJ/IdUoH
 7ndam86MuASsxd8RLPE0QkSLbcOJK35NfdTTp1ZYX4H5iTH/mpaJ1La+KgLprWdXdZ78nOFYLV2
 y247kX18+gbXfDs9w5kAmrFqb+5JU35Fea8twACNq8XW3ZWPb3YEjPHRQxxBHvGyvucBo4sLfDI
 CxqgsTkN6Y3EhF4fJnaPzO/mYYaTY3bEYAdIlhe8FhO6maA8bk4Q/0twU4zhmxdELAb1rQAOJGo
 +0UtG6uV1lg0K73U/Rl96C/O7Y7ro6sG2E8onFzMgSerDLT+gvBUdS+754XimR1LEMKzijT9Zmq
 Ykake3my55dBAekg8et+xVXAnqMtAAv+wI4n9Q==
X-Received: by 2002:a05:6808:1686:b0:4b5:5bfb:f25d with SMTP id
 5614622812f47-5683cba74d3mr2612506b6e.20.1794333006772; 
 Tue, 10 Nov 2026 09:50:06 -0800 (PST)
Received: from [192.168.29.85] ([2405:201:8026:213e:7392:6aad:f285:27fa])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4ae2302d8ffsm2043134fac.13.2026.11.10.09.49.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 09:50:06 -0800 (PST)
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
In-Reply-To: <20261101104727.141852-1-mdshahid03@gmail.com>
References: <20261101104727.141852-1-mdshahid03@gmail.com>
Date: Tue, 10 Nov 2026 23:19:36 +0530
Message-Id: <179433297650.153576.17456786292064820559.b4-reply@b4>
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

Hi ,

could you please review this patch and give your feedback ,when time
permits.

Thanks
Shahid.

On 2026-11-01 16:17 +0530, mdshahid03@gmail.com wrote:
> From: Mohammad Shahid <mdshahid03@gmail.com>
> 
> The USR retraining support check tests the address of
> USRRetrainingSupport[j] instead of its Boolean value.
> 
> Since the address of the array element is non-NULL,the
> condition can always true, even when USR retraining is
> required but not supported.
> 
> This issue is reported by script test_addr.cocci.
> 
> Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_util.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_util.c b/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_util.c
> index a8519f547dce..74cb65687a50 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_util.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_util.c
> @@ -412,7 +412,7 @@ void dml_print_mode_support(struct display_mode_lib_st *mode_lib, dml_uint_t j)
>  	dml_print("DML: MODE SUPPORT:     Host VM or Immediate Flip Supported        : %s\n", ((mode_lib->ms.cache_display_cfg.plane.HostVMEnable == false && !mode_lib->scratch.dml_core_mode_support_locals.ImmediateFlipRequiredFinal) || mode_lib->ms.support.ImmediateFlipSupportedForState[j]) ? "Supported" : "NOT Supported");
>  	dml_print("DML: MODE SUPPORT:     dram clock change support                  : %s\n", mode_lib->scratch.dml_core_mode_support_locals.dram_clock_change_support == true ? "Supported" : "NOT Supported");
>  	dml_print("DML: MODE SUPPORT:     f_clock change support                     : %s\n", mode_lib->scratch.dml_core_mode_support_locals.f_clock_change_support == true ? "Supported" : "NOT Supported");
> -	dml_print("DML: MODE SUPPORT:     USR Retraining Support                     : %s\n", (!mode_lib->ms.policy.USRRetrainingRequiredFinal || &mode_lib->ms.support.USRRetrainingSupport[j]) ? "Supported" : "NOT Supported");
> +	dml_print("DML: MODE SUPPORT:     USR Retraining Support                     : %s\n", (!mode_lib->ms.policy.USRRetrainingRequiredFinal || mode_lib->ms.support.USRRetrainingSupport[j]) ? "Supported" : "NOT Supported");
>  	dml_print("DML: MODE SUPPORT: ===============================================\n");
>  }
>  
> -- 
> 2.43.0
> 
> 
> 


