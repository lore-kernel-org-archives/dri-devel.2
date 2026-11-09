Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65606606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 17:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yWuJtjM2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C93DB10E536;
	Mon,  9 Nov 2026 17:01:48 +0000 (UTC)
Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFD8310F444
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 17:01:42 +0000 (UTC)
Received: by mail-pj2-f2.google.com with SMTP id
 98e67ed59e1d1-3b1478f06e3so282136a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 09:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794243702; x=1794848502; darn=lists.freedesktop.org;
 h=references:in-reply-to:cc:to:message-id:date:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=b/pzLwZr61TwH4Z8hnWdS9fb2v4tophLaBPLYRGm3iE=;
 b=yWuJtjM200e+eCQ/oe0UEQjI3M+nPrh0aRiaS9cnLf/l/nMdA1A5C2qswFczRMEUqy
 bwKn2RY7B6sjlpduCY/pgpoNZRC0eh7JIddYLO4HZjUY2PMXIc4+MeQSbPur+ubzdCuR
 NCsLPp3HfnNH0J0t9FGcAtrh88gEFt/Gn5C9FeYpeeNsNXGL/rAbt5sEzi6LZ783RKwS
 6ohlEe4dDWmNZQJJsxrkSgan7blsiKqUCVxml6HxOxBX9nMaP0iqmUoupS27epKZTDNQ
 RZrq4bXbPXxxzcsF2VShP4sFlu4SL5ATYem+GvK7dSdvhVUYu6SCfpbpr8Q/vNePm1cB
 4ovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794243702; x=1794848502;
 h=references:in-reply-to:cc:to:message-id:date:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=b/pzLwZr61TwH4Z8hnWdS9fb2v4tophLaBPLYRGm3iE=;
 b=YLlwhqUpjoYGTEnykWjcLTN3VEOhYtmtNZ+2CxV9jO9wdJKYryGAscA4CtxiHRfG0z
 /3PiB23PlDJAOAWFWnrhAcqBpVkaLz95x5QqfK7s+BEsHgbFE+VhrSeKO3STgdUxQfDx
 8/1aSttZvEAJtQSwN15BthsZcHSrpIW+aZDo/GcKL+ce5bI8gh/lBrJJ1LK9i76TLunX
 GEsPEWxapp7NsTP7YIiiMzB6GUY+iSZRTQJwIzjdK/Y70hYAMg1FwwCIuUXe9X5GQEEl
 DT8qP+3eopcRsYKPHIu6qLv+kcMICLL3MKrpoxa+Wz3oFGEkdNPcHLKkEebL8NeGkFM6
 ACJw==
X-Forwarded-Encrypted: i=1;
 AL+hErFwFrmsrasu5kjQD8jeFfjV3IuM8gtWqLH94OgKrVdeFMOOUm4s+WH981yTgZQFS2doVfLZosQgxvA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/aQeJ0XXjf0i7etBbdKZC2At0DJa3xrT2IQ96y2EIPm6+efV5V
 q4MCVgKYkYdpwFRmukHgZGOXsST1XeVMI4u3hpgA0QHT6XZtaI24IbPa
X-Gm-Gg: AYBFou2bgQcvv6Uyp8oh5uwTKg1VGBY/2r2TQUmRHU2kFxWHSJWZQHmDqOD4UPHGowZ
 VuyZpiOFXuaAYXJ+1xGCPiVJaT+2Jz08re/X+hF9ZLH2E2CQYJNLnPFxkOOTDh1YM4jYmtL9T48
 j58K1wycp+DhsjubEK4qCX2NrGHhixUnUZBhQ6+7os5k8QiZe8NFYEWUmcUGLWkQtSQytlRPn3z
 pxjpK5RrL3vV+ne2HAxgIYF6YW+6OlGDqPZ4MfUt6PTkrziVRsxvl6sn3nAX6r1RzyXesaQYpnr
 uT8OGjvulzMppRhk/ytoWJtColZ52GlscBoqtDCO+SivHIdGTtNo2cVaTgRzdHBYTXq+kY3NAY9
 qhez4RRtRpMTd8iFYlkSBy3H3NIZC4N44VWGBfUSk94Ji06SAP9F+SZNiI7+lJ/lwBtege7EPN7
 d9VKSooerU/C9RUTIXbRCh0TRQl1yVhfEhPWHW6g+hVJeUG4n3fpGJkiVNH8JiM4jnYGs3n8OFB
 Iro9b8gb9o2ND4kbLV9l1gL7/4jt4/zhtkUAQU2bvhNG6x9Y86EuThLW9O3lRI0+7MwTOF79Aa0
 3IdOV09EjYBxbETntKvJ3JZExJEKin2sJEIESrXPSqKiRg9SbXFyLtAnKK7ZZ9NMmrvBmFaq3+g
 zoVAGw4Wh1IbpWoDqkkHcv9NjKXh43w8n
X-Received: by 2002:a17:90b:2cc6:b0:39e:6795:f7da with SMTP id
 98e67ed59e1d1-3b166c89a19mr230128a91.19.1794243702117; 
 Mon, 09 Nov 2026 09:01:42 -0800 (PST)
Received: from [100.64.227.9] (n106-71-19-159.sun21.vic.optusnet.com.au.
 [106.71.19.159]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b16708f963sm211545a91.1.2026.11.09.09.01.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 09:01:41 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v10 11/22] drm/amdgpu: add SVM ioctl entry and fault
 handler module
From: Aveline Noir <jm5905938@gmail.com>
Date: Tue, 10 Nov 2026 03:47:18 +1100
Message-Id: <179424283809.193292.9522281129166256376.b4-reply@b4>
To: Huang Rui <ray.huang@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 Alice Ryhl <aliceryhl@google.com>, amd-gfx@lists.freedesktop.org, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Danilo Krummrich <dakr@kernel.org>, dri-devel@lists.freedesktop.org, 
 Felix Kuehling <felix.kuehling@amd.com>, Honglei Huang <honghuan@amd.com>, 
 Honglei Huang <honglei1.huang@amd.com>, Jenny Liu <Jenny-Jing.Liu@amd.com>, 
 Junhua Shen <Junhua.Shen@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>, 
 Matthew Brost <matthew.brost@intel.com>, Oak Zeng <Oak.Zeng@amd.com>, 
 Philip Yang <Philip.Yang@amd.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Xiaogang Chen <xiaogang.chen@amd.com>, Yiru Ma <yiru.ma@amd.com>
In-Reply-To: <20261021025915.2433837-12-ray.huang@amd.com>
References: <20261021025915.2433837-1-ray.huang@amd.com>
 <20261021025915.2433837-12-ray.huang@amd.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ray,

On Wed, 21 Oct 2026 10:58:50 +0800 Huang Rui wrote:

> +	ret = fault_check_allowed(svm, fault_addr, write_fault);
> +	if (ret)
> +		return ret;

This checks the VMA permissions but not attrs->access, so I think
INACCESSIBLE isn't really enforced. SET_ATTR invalidates the existing
GPU mapping, but the next retry fault just maps the range again.

IN_PLACE has a similar problem. With preferred_loc=LOCAL, the
migration added by 22/22 can still move migratable system-memory pages
into VRAM on a pagemap-capable GPU. Both seem to go against the access
definitions in 01/22, and the prefetch path doesn't check access
either.

Could the fault and prefetch paths check access before mapping or
migrating?

Thanks,
Aveline Noir
