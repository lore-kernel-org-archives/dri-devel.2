Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3B4606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 13:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m58SLvep
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2412C10E897;
	Tue, 24 Nov 2026 13:53:41 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9C9510E897
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 13:53:34 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-6bab377105dso2685681a12.1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 05:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795528413; x=1796133213; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=q6JmaR/skCNhplZj+MXI58e71T+5r4bXzYFahMOHLqU=;
 b=m58SLvepma63hKfUicp9D5hRuvZR+PURpx9rhXMyGZjM/tzTrICaSAKMfLKk3hvHR0
 DdtocdfVFyoi71Q9KW520FMplKjdKv+42tux6dVIY7rvxu5+tlNZZ22oMbiSo66rs3Q+
 tBmg7XrLIJNJDPFOKfcRC5UhNy1q84nQGFeHfpcvsE8J6CNnVMeH1H9XzbTaVU7yDJZ3
 uK44Ct+EszXTvcMKCBYxk09EIRcXymSUgHgIZk0vfGoLcc3XK1P36RCXjHD3j+trWzpB
 fYih1u9VEd7Qy+Og60GdyfQfXM/vMg3BO/7y/VjJT1w1r6UFWQbhQXyJJyHFTf47ExO4
 t4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795528413; x=1796133213;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=q6JmaR/skCNhplZj+MXI58e71T+5r4bXzYFahMOHLqU=;
 b=lsTlnqAMlozUryZuqiDXTE/3u/Rv56asmkjcPfPB5rf9V+U7F0jED82bMlTVcLaQrv
 pN9/WnA90vY3QvLIr4RZ00ywAGaYjMq3VF27S+Kbdh52CLV8touLsSDciE6Z7iAEeObY
 xiC9Opc6JfR33g/3Z6bXtnx9r6L8qkKmNy4UE3Qdo8DZv1mW9IsNOtnI7t28iQR88jBF
 jssWxsL6IF3ft8SGl21Jubs+708MCPi+Cz/f59LdeYeqSWf9lNSr5ZkQ98kfBJgBNM+S
 lG4wdBLxIoiEaEg3RvyNj7BWakIkJQIOjxaKeApMtnLOdsoMxjcgOYBhFR/wrNw31quQ
 81cA==
X-Forwarded-Encrypted: i=1;
 AL+hErF/HorsSVyqq0SU/8Q1EeDc12E7caRVoctE3Xqx6d0iLPAxDjI5OKn75WYOa1uU1J65Nn/6x2M3tdk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+q2vIv07ca+faPzEoBWfUZZmUYXGP/6gxe/LxouCDd7ZsMdYMP
 XpwS7URJtVlzs8RbsJV5LyuPoVB9Nep6yso+35AFpDZNNbxfb6aYlrqT
X-Gm-Gg: AZFdTZchT7TIUYlKTpumaljoneIKW9TrRFCcABW6jphGKEjAJz96LkmUmtXVPFxfsLK
 hUYEJyg4p3/fR+b96W66UczqNcMH/7jMVAsS7qASC1F0J+3tFGQBYQUbnmg+OKHk0gLLV1bcqoQ
 vQpCR9Md/NobZ/JdPil3vZIxCwe0Bn8gUESffaOCalR6ZeKDF4tW5PSElwUYHypA65ZXqhWmBIN
 KQ70B0q0gqFnnQNmtYMXQAUg6gWYlomzjPh/QmCcJojETr+zyz7Pb9nl4EiqAOru5bbsD8OPnQj
 3xIvBbMLie3uBU5N6MFCKAbDHX64WdMT334M5JD6LkT11OO99K/Q88cshR3PeF5jTSZGjxcvOYZ
 oG60ScPN2ULLlE91mH2iDhKW1fsfPNmaAFppAcR/+J6I/fxsjyMufiVAR4Ev4YEKPnE7mf2HPKr
 2lBT2kUd8ePGb8Q0T/RvdL9l1MDVcpZYfLGlw9mtJtg9fpGPppC80Hw+gg2eWacx0xRTaoxC/Re
 /010NnTn2oRxLO4oXZ/eHxVX+66lrazEyvT2uhzPsVOzKHZqabI5pwuPV3JRYEu14jKhdY2/fKQ
 Uf7ubPQh3cNkXANBtCPcHOkJBjmmE7M=
X-Received: by 2002:a05:6402:c70c:20b0:6ba:1347:5cd with SMTP id
 4fb4d7f45d1cf-6ba37c7ad6bmr7580207a12.2.1795528412985; 
 Tue, 24 Nov 2026 05:53:32 -0800 (PST)
Received: from ArchOarora ([95.179.249.152]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba36d730d1sm6833598a12.0.2026.11.24.05.53.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 05:53:32 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 jose.exposito89@gmail.com, Jonathan Corbet <corbet@lwn.net>,
 Harry Wentland <harry.wentland@amd.com>,
 Lucas De Marchi <demarchi@kernel.org>,
 Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Kory Maincent <kory.maincent@bootlin.com>, sebastian.wick@redhat.com,
 victoria@system76.com, thomas.petazzoni@bootlin.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Simona Vetter <simona.vetter@ffwll.ch>,
 llvm@lists.linux.dev
Subject: Re: [PATCH v6 08/43] drm/drm_color_mgmt: Expose
 drm_get_color_range_name
Date: Tue, 24 Nov 2026 14:53:15 +0100
Message-ID: <awWWuPbKPoIkMxNC@Oarora>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120-vkms-all-config-v6-8-78ace90f4fc1@bootlin.com>
References: <20261120-vkms-all-config-v6-0-78ace90f4fc1@bootlin.com>
 <20261120-vkms-all-config-v6-8-78ace90f4fc1@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

On Fri, Nov 20, 2026 at 06:58:50PM +0100, Louis Chauvet wrote:
> drm_get_color_range_name can be useful to print debugging information.
> Export it so it could be used from VKMS.
> 
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/drm_color_mgmt.c    | 2 +-
>  drivers/gpu/drm/drm_crtc_internal.h | 4 ----
>  include/drm/drm_color_mgmt.h        | 1 +
>  3 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_color_mgmt.c b/drivers/gpu/drm/drm_color_mgmt.c
> index de219c23322f..a65fef5702ab 100644
> --- a/drivers/gpu/drm/drm_color_mgmt.c
> +++ b/drivers/gpu/drm/drm_color_mgmt.c
> @@ -512,7 +512,7 @@ const char *drm_get_color_range_name(enum drm_color_range range)
>  
>  	return color_range_name[range];
>  }
> -EXPORT_SYMBOL_IF_KUNIT(drm_get_color_range_name);
> +EXPORT_SYMBOL(drm_get_color_range_name);
>  
>  /**
>   * drm_plane_create_color_properties - color encoding related plane properties
> diff --git a/drivers/gpu/drm/drm_crtc_internal.h b/drivers/gpu/drm/drm_crtc_internal.h
> index f3a3ffd358dc..168799fac7c8 100644
> --- a/drivers/gpu/drm/drm_crtc_internal.h
> +++ b/drivers/gpu/drm/drm_crtc_internal.h
> @@ -38,7 +38,6 @@
>  #include <linux/err.h>
>  #include <linux/types.h>
>  
> -enum drm_color_range;
>  enum drm_connector_force;
>  enum drm_mode_status;
>  
> @@ -119,9 +118,6 @@ int drm_mode_mmap_dumb_ioctl(struct drm_device *dev,
>  int drm_mode_destroy_dumb_ioctl(struct drm_device *dev,
>  				void *data, struct drm_file *file_priv);
>  
> -/* drm_color_mgmt.c */
> -const char *drm_get_color_range_name(enum drm_color_range range);
> -
>  /* IOCTLs */
>  int drm_mode_gamma_get_ioctl(struct drm_device *dev,
>  			     void *data, struct drm_file *file_priv);
> diff --git a/include/drm/drm_color_mgmt.h b/include/drm/drm_color_mgmt.h
> index 133ca77d91c7..e91f494e5a63 100644
> --- a/include/drm/drm_color_mgmt.h
> +++ b/include/drm/drm_color_mgmt.h
> @@ -114,6 +114,7 @@ enum drm_color_range {
>  };
>  
>  const char *drm_get_color_encoding_name(enum drm_color_encoding encoding);
> +const char *drm_get_color_range_name(enum drm_color_range range);
>  
>  int drm_plane_create_color_properties(struct drm_plane *plane,
>  				      u32 supported_encodings,
> 
> -- 
> 2.56.0
 
Reviewed-by: Oarora Etimis <oaroraetimis@gmail.com>
