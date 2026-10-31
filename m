Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7A9606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 01:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=IxGMOILp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4EEB10E2A9;
	Sat, 31 Oct 2026 01:49:06 +0000 (UTC)
Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com
 [209.85.210.226])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1E5210E2A9
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 01:48:59 +0000 (UTC)
Received: by mail-pf1-f226.google.com with SMTP id
 d2e1a72fcca58-8a06b27bf9bso558247b3a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 18:48:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793411339; x=1794016139;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1SgcnqVdQJGi68NMbZM9x7rfQgXngTJp0Jblk14QXao=;
 b=Hew7LR93cNrD/Ao+zRMQ8vn6je8DZ6d5loSUlL4IXMaVnZruvwzFVQMfcsiHrhOwW+
 vUvUDhAsHQvWwbYLZveAJRqVlShfEq0NdheEAFwNtFkXeIF9r0ILlAh4R25ZI+n6RuND
 61xa/sfOwkIXeuDYTqQOUyLjwivQcwmzbBttmPeKgOszBnPjEHkebItcQT+phkLuE9xW
 G1GkPzqwdytTTjvXvjIAEM4VospUkj16eZWpWOKNz9roioIaVgf4CwAtwkegEVf0AnwZ
 rHNziG8tqezRDgVSh3733oe50KBE1wiYwWm5nrSC6UNuWxTQPEwVS95VAXd9J1yp8yZP
 VBsw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzrKUpTWJuoGMGiotCnYlPuttGjMOQ0Yin6MuyR5OR/f4B6usg+EE6RfFs7tzI0529TpA4r1UdRoA0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLsYkvqlFsZeYcYZLjbGCRlpbx2EwygFg5dogI0v2mbSJ+EOVOl
 gzcly7l0xot+5sAFEucpaqK9kItHbXX6C9B/zuz91qJ38j38OMXPXtoWdqhVJLf3gHWTt+OSkVH
 ZVc9hh8aeOG4VF0d4YdwXLqj+JmuyCxhQOVZwiMWEEF2jfmZNBgNrMy/QdGgFUBusaWP/2fR1tV
 9JFeXLKePHjZU64mgnArNVtrgQ0z3N+H5+JcCWY7qVeK0XUerouI2WZiYTo5k8DEL0tHja6oogA
 imnW9puaw81WdzbIlMvAF46cDDK
X-Gm-Gg: AYBFou3H1EcJRPQTozt9xlJ5PQdzjYLfb90/KaaPtsSTAa4xCv7In4OA5cLFYCXTw4k
 56KV0lN+w6QEjptydz4k/wmTR0n8Sf5ybIhL/i/0D/K70MKFUgUh953/cwNCfTRycQob3QKL9Pm
 U/HYI5Rj3XyoxU/gC0jD4nEI6iqs8xSvuMjIssy9Z5fsetef38YBcWiWAy0ezR+oaCxOH8XPi5J
 8zGy0gF+ivv1QGq07gi1eXKeuqZNt45EOJgIngtGr3Q5RGx/0YD1BQRMi90fZE5wR8EGCOxhceS
 r7UsUV9CfwXS1YhMUq+BeehepIWYGyC4BJw2d1HposL+Hr+dVAmD79BUcHVnZwNfa5jJnnl+Qxb
 cC86tEzrTnZfT6mhbPvCvc0a/SA0L5DtUL5N+893sZDUCvcTD4icCfKQOvLCCfpXWKW4MggiGkl
 FLuewYLrNJPyom8YLSvxZf9HAzo/A+SUuWeppcY7SX
X-Received: by 2002:a17:90b:584c:b0:3ac:fe93:a731 with SMTP id
 98e67ed59e1d1-3ae8981e640mr3067122a91.56.1793411339326; 
 Fri, 30 Oct 2026 18:48:59 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3ae6e84adc9sm5018763a91.5.2026.10.30.18.48.58
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 30 Oct 2026 18:48:59 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33713e5e6daso1555518eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 18:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1793411337; x=1794016137;
 darn=lists.freedesktop.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1SgcnqVdQJGi68NMbZM9x7rfQgXngTJp0Jblk14QXao=;
 b=IxGMOILplqV1btZhW+h56nIFnJpiHPJUGM9MTCFTv/gEsMN54hN8bXAPXIWwyUp8r4
 fUSts0hL28rvHeyhgEpLLu9y3NkAeNL1rk7tOMXVdNzzyjpmWrsTTDjc7a/JTEBCntua
 bMyvoY1i19Rsv62tfdx3GRN39n1KF4dQjgdUg=
X-Forwarded-Encrypted: i=1;
 AKwUvBwkDfLXyrnl98EntYYzf/VgZlKIQQ2OmNN+ziydPlxYoXzaqyZBvfY3DSbAdpGKSUuhJ3gsIAY3B3A=@lists.freedesktop.org
X-Received: by 2002:a05:701b:4505:20b0:154:fa0b:6df1 with SMTP id
 a92af1059eb24-1ac5d69f9c1mr4947224c88.37.1793411337442; 
 Fri, 30 Oct 2026 18:48:57 -0700 (PDT)
X-Received: by 2002:a05:701b:4505:20b0:154:fa0b:6df1 with SMTP id
 a92af1059eb24-1ac5d69f9c1mr4947199c88.37.1793411336852; 
 Fri, 30 Oct 2026 18:48:56 -0700 (PDT)
Received: from localhost ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac1a9e2ed3sm10290353c88.19.2026.10.30.18.48.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 18:48:56 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 30 Oct 2026 18:50:17 -0700
Message-Id: <DMINAFH3EEBW.26VZ1LKJN1CSI@broadcom.com>
Cc: <linux-kernel@vger.kernel.org>, <bcm-kernel-feedback-list@broadcom.com>,
 <mripard@kernel.org>, <maarten.lankhorst@linux.intel.com>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>
Subject: Re: [PATCH] drm/vmwgfx: Fix use-after-free race in vmw_dumb_create()
From: "Maaz Mombasawala <maaz.mombasawala@broadcom.com>"
 <maaz.mombasawala@broadcom.com>
To: "Nair, Jayapal Ashwin" <jayapalashwin.nair@amd.com>,
 <dri-devel@lists.freedesktop.org>, <zack.rusin@broadcom.com>
X-Mailer: aerc 0.17.0
References: <48e6780670395107cc9853bf63fa7ac1d034cdd7.1793249917.git.jayapalashwin.nair@amd.com>
 <DMHS7SIDIUGJ.168385UCMC4QI@broadcom.com>
 <7a822adb-ddb5-4338-8949-3ccb0942e0a0@amd.com>
In-Reply-To: <7a822adb-ddb5-4338-8949-3ccb0942e0a0@amd.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

LGTM!
That sounds like a good test case to put in igt, please do so if you can.

Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>

--=20
Maaz Mombasawala <maaz.mombasawala@broadcom.com>=20

