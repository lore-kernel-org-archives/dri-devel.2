Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586A5606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fhv8Fp86
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89719112819;
	Fri, 27 Nov 2026 08:29:10 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D61410E848
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 12:37:21 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so66523005e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 04:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795696640; x=1796301440; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+fzTSQ4IC4vfCdf4lnBWrMCmW+A1sJUKi7Yho2wo30c=;
 b=fhv8Fp86liVnLa6yI760vXR9uHnQOSTPZ7ozIfA1r9OqP9WXGquGfIGm3BoLflFh7I
 ye6HJ+19NfKR1iN8PLGomYle3bJqg4SPYBU0ro4QMHHa4vmmVrrl5hxF9YuHnhxmhbwc
 dtC4oRCwlatkUbylmMH0Mn28x22lz/zEDXPGP36l0GWrA9fOu+BKcpct5n3a3osuNzCg
 nuf8MJEUpT2CX7QnQf19Hz8i/4vLm45dB/x+yDDcBf2kdoyQAlmMQfr1S7Hi//g0S5Gc
 7Rve4xAY5NpLBWYjkVXjtfLJj2qpYloGkASy2Rfh6hVp9UMq/bXTi8N/bakb/4zbOqx4
 FB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795696640; x=1796301440;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+fzTSQ4IC4vfCdf4lnBWrMCmW+A1sJUKi7Yho2wo30c=;
 b=dqobnErTg34A5hrSy338taJ36rFdOteqbz6mbFdngjz/c4W5awy5WLTt1W0T7qUppE
 3+p9puZNx/JkH8V2R9XwkI0iLhmhTU41omw2r9YmJfSICclrt8Q8uujiG79RjS9u6eSY
 6yYDZ5LCuOVLwMAJUJQBmBw01JpZNS5IC72L+z2NADVYSPd00Heh8b9QxEghrTMZosRw
 ceME1CspMUs/k5TQJODoXEYLJ6YiBxmsvset3smR5KoF/rYyUkhyZqKyYjusc/h/1YIM
 VQ116ajtkEKoQklTWQqJNiFUO/fsdycuFV6u4LpLmPnoTyVTqQ8U2C3uhv9E3h+ci9Cx
 yEFQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEkj1lY+1yqgEePG4mYxIdAGlg4ZPuyYnnI4x8H6KAXBo9GjCLWRLhu0YX4Yo38SCfD5G7UkWLx/lE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/X8jR12AgJsFC5t6McCVUjMWVnpLbh1aEAdcte4kWhVnnRJ68f
 Kds7rhvO+yUSf+gQyKFoWw9X15Qn7k9KV8nI5y9nNc+S7OnoImEhyCs=
X-Gm-Gg: AZFdTZdWWR8hFWW+uDbeQCIyhFT++swUttiURR3/o2c1YlGqwVcQFguxVmmt9me401U
 +rncwHCPIcyVy6Pjje/Njlt3BwAh+aLdCGSbYJXj0DVS+tlodj8NmeICoUZbgDze6XnB4i/Xf5+
 DISwowHnHIlCc9g72OLCLuMkkwaP2pZaNkr9bwwiPrO3BxhIjayEOMq3GagY1mAJ9woA3KKmyaK
 xHA9zvysoedTdZRPagwYPm69ggatXV9aLDJsFm0lFsvRs6hgYmrnZJyvIw5dWmkLiXAR1jL5DD1
 EPb0qsE+BzHK8bJNf/tze32e7d6AHhbvFfa60K7Lxooq7dB4QkboQ/cl+HRK0dyLffUOH2Sfd0g
 3wAHZfmJx3Ox33EiHT3DfCMTtdgIg/PoEv/04WsQIoExL8UYmO5Jq1Vp4YW6xt8mbVZXIuvHrWj
 EIB1U0ALNVU41JAOca9qPF2VRkFg81YrNxav+7YVIC4VWxvGao7eeQviaGDOw3/8btP86UXsOZY
 NkU8AcSrZMzybVhjCTHKlGjvJ/uKQKWyJTyHCDcsSdzfmKzJV2uxLeAz+ZNlT12s4umUiC03Xfg
 3zD4vcEfZsaE2v9FsIsg4kocw5OdJdkQ/btmvc00u/2PUbSJ3SHLh2JTeJn1wl7xdKBsIiW5tlD
 E0qE6F4NCyBJrduHTV7+UjV092TTRXNvQCySSAqPH41QrMsDj8i4P34EDHtwMaQyIm1acXduqMw
 MOv0ZXUtNEf+cINmYVIQ7pNfYdRm5WW6MdpC8euIhbuIaqC4nqPuclPlw26+iCkQSVCUwFGAO+B
 g7d
X-Received: by 2002:a05:600c:c168:b0:4bb:81b2:c801 with SMTP id
 5b1f17b1804b1-4bb889238f1mr412564745e9.20.1795696639507; 
 Thu, 26 Nov 2026 04:37:19 -0800 (PST)
Received: from archtop.localdomain (92-242-248-48.broadband.mtnet.hr.
 [92.242.248.48]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884a3a3dsm586455245e9.10.2026.11.26.04.37.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 04:37:19 -0800 (PST)
From: Jakov Novak <jakovnovak30@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>,
 =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>,
 dri-devel@lists.freedesktop.org
Cc: linux-kernel-mentees@lists.linux.dev,
 Shuah Khan <skhan@linuxfoundation.org>,
 Jakov Novak <jakovnovak30@gmail.com>
Subject: [PATCH] drm/connector: fix kernel-doc string in drm_hdmi_vrr_cap
Date: Thu, 26 Nov 2026 13:35:44 +0100
Message-ID: <20261126123544.16968-1-jakovnovak30@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Nov 2026 08:29:09 +0000
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

Building the documentation currently with make htmldocs gives the
following errors:

WARNING: ./include/drm/drm_connector.h:293 struct member 'cnmvrr' not described in 'drm_hdmi_vrr_cap'
WARNING: ./include/drm/drm_connector.h:293 struct member 'cinema_vrr' not described in 'drm_hdmi_vrr_cap'
WARNING: ./include/drm/drm_connector.h:293 Excess struct member 'mcnmvrr' description in 'drm_hdmi_vrr_cap' (did you mean one of: 'cnmvrr', 'cinema_vrr')
WARNING: ./include/drm/drm_connector.h:293 Excess struct member 'mcinema_vrr' description in 'drm_hdmi_vrr_cap' (did you mean one of: 'cinema_vrr', 'cnmvrr')
WARNING: ./include/drm/drm_connector.h:293 struct member 'cnmvrr' not described in 'drm_hdmi_vrr_cap'
WARNING: ./include/drm/drm_connector.h:293 struct member 'cinema_vrr' not described in 'drm_hdmi_vrr_cap'
WARNING: ./include/drm/drm_connector.h:293 Excess struct member 'mcnmvrr' description in 'drm_hdmi_vrr_cap' (did you mean one of: 'cnmvrr', 'cinema_vrr')
WARNING: ./include/drm/drm_connector.h:293 Excess struct member 'mcinema_vrr' description in 'drm_hdmi_vrr_cap' (did you mean one of: 'cinema_vrr', 'cnmvrr')

This is because the two member variables names have changed to cinema_vrr
and cnmvrr. Change the kernel-doc strings to the new names.

Fixes: 014da1db5e64 ("drm/edid: parse HDMI 2.1 gaming (ALLM/VRR) capabilities from HF-VSDB")
Signed-off-by: Jakov Novak <jakovnovak30@gmail.com>
---
 include/drm/drm_connector.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 2ee7c59329aa..bcdb402a7ede 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -265,10 +265,10 @@ struct drm_hdmi_vrr_cap {
 	/** @fva: flag for Fast VActive (Quick Frame Transport) support */
 	bool fva;
 
-	/** @mcnmvrr: flag for Negative M VRR support */
+	/** @cnmvrr: flag for Negative M VRR support */
 	bool cnmvrr;
 
-	/** @mcinema_vrr: flag for Cinema VRR support */
+	/** @cinema_vrr: flag for Cinema VRR support */
 	bool cinema_vrr;
 
 	/** @mdelta: flag for limited frame-to-frame compensation support */
-- 
2.56.1

