Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDA2606A6BA
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 14:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O/MZB+5F
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67BDB10F641;
	Tue, 24 Nov 2026 14:08:29 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DE4B10F63D
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 14:08:19 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-c50aaad19fbso505799866b.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 06:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795529298; x=1796134098; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=anD5m1AxXBnKPgg8ZQZ0gwUoffnh9QZT8UfPtY8eE3c=;
 b=O/MZB+5FzHq89ZHVEBHhqZl8IU52vDlE+VJGHyzM8scD4C4cxGPu+FvayWKRyT2LMJ
 zf15GuORjdgTOm0CDpAaqLOKlSVpnUh1wLaG4jgZ5xlmQe03mtm9AhjiIUjPXfbl+y8X
 Ilg/nTV5ZJtoZ+eLj3ToWKUfL/YqGPR54ImauWVpNysWVnE+39aGdwWsIkoA9jR+Uk4c
 CRCfSR9Ia/Z74jJVVb48Cv13wQzxDzq5rQR0VItLnjpasxfF9BuGDsBc7JDycPtntauU
 pgniFztJKgtjsSap+prS2hY7Z8VFun5O+atPCOY5WL7pYo5IBUzFT5dMw63v98SWKL12
 cL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795529298; x=1796134098;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=anD5m1AxXBnKPgg8ZQZ0gwUoffnh9QZT8UfPtY8eE3c=;
 b=2CkFXadgUCtyVVanQ58Z68YviE6Db5Smj/4OD0r1zD2xUVkyJoaDMBNAxDvHvpM7hi
 vkDQvrAXr4Or1bvq4PuLobJuBKiRsmraRcH4rD76Q+IHqE+xs1MhwkFFEQCRFlFhLqoC
 hIwgKCYwaSD+1Xl0YF0ej55BNkdXnOpbt2VEdJxlgtgsOUBnz79EH1A0IsB+4EWfKj/r
 5nqnjQNACNfmNOP48vvz9Iqxj6fxVTfqvexPPGD3neG2FxLPOOEF8P8ZryOIJZqJZji8
 P7z3VBuNGfKfWktURtB5Ko4d7Jw1gKHV/26LMqOYSRyM8E3I9XdXO2xEB7bqsqZ8isWC
 pDwA==
X-Forwarded-Encrypted: i=1;
 AL+hErHKT2B3wIAtzIs5MxHs0CAckV7bI10JJiioG6MtlS4xkzfv1A8GUK97wslcw5w20IFDN3u0GUg/cn0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8/0xytwHmeeeAk3s+8qrA2K8y/vaftBq+CmOBbRHv/+ntJUCUC
 XZZbCbyBoJW1AfUt9KWcr//OcQhU163qx45fbeccX6mJbsQCyZBLszFU
X-Gm-Gg: AZFdTZdhNRafQMM20M4wiBxVN5kEaGGbGkQ2nsb+XIchchq4VJEkL2tKA1+TGdVDNSH
 jZaYFvhPBuOcluShHAESLBjY7TUm6Bs47Ili7KYbAZJ7M6DEhXdYn1v2L+IoikHnASn9YG1ITtt
 lR6neVsK5QE7n0Yy2pAg4PLOCa9IooTBFd1FdpoTf5VLPDjFkxbXJ1c0qD2J10Pb5ZmTuexgrzV
 l/DBLChKg2wk2H4GV+cVoi7r+foKIntq1li746EUmFwFHWOm2bvTD+A8LaSr20Z4mX5GHrwtS3y
 7juURh7Pgb7r2bN+5B2fTDSKRi1LMiavBEpCOFncuBqRYUT6Ew9F1HoCF0+SzrU2TkO9lI1o15q
 7kS+RhcCRwBg50Eze5FR6tpDYFz9MR2GO9oSpKeH27WHp6enyHzfNpw5UXBZAUxy2SQCFmDE4vR
 4C5QZF1wXvrxTYfPLemd4HccvKcVJ1NgYQ7KhjBasFWGXrqlRz4k6LCJ3n7ADWFtqz46bnF3NkX
 0IBMmV8hd9wz0Kh5pV6jh9m66+VqTk/9AH78x/LOTbzB9k1k8o4w7zgG07On0F1GSsxwTPgQWyz
 NZve/lDdOpFB1FqbrhKVCpRRa1FT6Dw=
X-Received: by 2002:a17:907:3e92:b0:c51:9ab4:393c with SMTP id
 a640c23a62f3a-c519ab43c77mr120246166b.32.1795529297432; 
 Tue, 24 Nov 2026 06:08:17 -0800 (PST)
Received: from ArchOarora ([95.179.249.152]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513aea1fd8sm512929666b.38.2026.11.24.06.08.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 06:08:16 -0800 (PST)
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
Subject: Re: [PATCH v6 09/43] drm/connector: Export drm_get_colorspace_name
Date: Tue, 24 Nov 2026 15:08:02 +0100
Message-ID: <awWaMHsJ2EAn1Tpa@Oarora>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120-vkms-all-config-v6-9-78ace90f4fc1@bootlin.com>
References: <20261120-vkms-all-config-v6-0-78ace90f4fc1@bootlin.com>
 <20261120-vkms-all-config-v6-9-78ace90f4fc1@bootlin.com>
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

On Fri, Nov 20, 2026 at 06:58:51PM +0100, Louis Chauvet wrote:
> Export drm_get_colorspace_name so it could be used by VKMS
> 
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/drm_connector.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index d66188521881..fbff5871355d 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -1528,6 +1528,7 @@ const char *drm_get_colorspace_name(enum drm_colorspace colorspace)
>  	else
>  		return "(null)";
>  }
> +EXPORT_SYMBOL(drm_get_colorspace_name);
>  
>  static const u32 hdmi_colorspaces =
>  	BIT(DRM_MODE_COLORIMETRY_SMPTE_170M_YCC) |
> 
> -- 
> 2.56.0
> 

Reviewed-by: Oarora Etimis <oaroraetimis@gmail.com>
