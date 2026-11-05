Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D8F606A330
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 18:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FADdCizU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CD5110E366;
	Thu,  5 Nov 2026 18:36:51 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B48B10E3BF
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 18:36:45 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so19265385e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 10:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793903803; x=1794508603; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LT4ku/JNKyZWGL3WmWvhNxWBvjdOBJG3rnFdkcbfP+w=;
 b=FADdCizUB0Cmyyhv0bbf3CNAFoetXg9T30R2Ia9r3+sDKlasj14uHZbyqQ1AFYd1Y3
 r5PWegt3SGUvicWgSZ8NyRyBy71fHndJK4Ab5UB/KGEP5OIcRPGtaG2D/wi+iLQNbi8a
 BvjrXUkeP95yks+TaITNGiuIjqm/eu3Kee2Vj4Q6Uuj8l7Ermp1gmUmf0NA9EmgP3Jd7
 lhaGA3BwGIaPHK7ahPWY9fUKU/TrtyqTQ7IT0EAs9Qlg7g0+oDb4IRf9l/28WnXu8ulD
 aJPbdVmBwQ3TFLdajMP+xGVU4eMP5Wu1wDi75IH1xzypnEh1p//wmrI51MjK19/G0U9+
 f8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793903803; x=1794508603;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LT4ku/JNKyZWGL3WmWvhNxWBvjdOBJG3rnFdkcbfP+w=;
 b=mbsOnfqOyxP5UajyiQ9Nt/Dwku6chbbAbslWnH8oXKJ791ad1FYxc8nrgJyE0Iy4EQ
 T8bCZ2qG9RR4ulMIsy/QkUDFtc6QqiS9jMchWdzSCF5S98HRVEV9duhwvYt2H2XlRSxy
 4KP4VqNorx8JwNC8hr3PpPPhJhKIEYBkpXfYFoqMgDICZ47GDOuciteQzWnk9HeF5k6M
 NQNXwx3hhLywifnHGKjyHCdTnvQ9p7jR3PsstCrepv2ngdD51JBKr81XOj+Yt9ogjYA1
 YjCmVGWT3LC3qnX8P/DspvPPj2A2iajlp4j8UXqHa7l5UJVo2vwCapy23Nji7bQtTVjS
 Jb4A==
X-Forwarded-Encrypted: i=1;
 AKwUvBworLKM5x3bboECtyliajbvNc9ov61h2X8dH7dEWCqIsAI6+cr8xfNFjSI3qtHmOj2ZmiYrgn1u+bs=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8OJow5wFEaCldMbUaEiSMSwN5sjeo/JntX+NlaEJr+AJ0EoJ7x
 yWdeBACmIJ17GdGavt69e7hSTHf0SlGYmz6WkLdpKSccWTHKulKE91z9
X-Gm-Gg: AYBFou0QbAsi0+/QbugWplgeEJH7WQ1GqWVkpRjAvDKru28xcvB5UMa/c5aWe84JLya
 N0JdOJAq7U3lXIUgBPpD1snzCC1wUpuP4WiuqkzX3cKHLyM23Cmh7PtFrYfzEAT9eP9biypYSA9
 4GaifZG6Oti7HfZ9ikWtS+boKEE5YHq3X/J46ce5jRL/r/fFVlBd72lop+nVAk9hA1E2a+HtxeG
 I5UH8eyY1oRlrYzkPqKJAG+xudPD2mP4q4mk6IsRRnkXEQY4bm9yDa5rUDFl8GhSTbwO57u2MUn
 SE+V/vaH3fB+kev7x0M7igS7aLsEnnVxPy8wtMp7A4cGKi+Y5pc26oQTRyhVe32AvpZBybIXA3z
 ADKNXL2mIYHENAATIXrNPBMbpRHDGQjVcRjOFoAvuGqGrVrJleMxJ2ngCDCnlgEOKEqQFmWbOMS
 tLnCEKdFMQp7X3d1XWV4g0z7BXdLGrD/L001gIIdHVRNXE1St9ikflyORIAan0EIOLJ4VU/B84O
 7iiDThn78DslEjkJw5G8coMQupMNaLZRlscKJoB3FOJI5BeIWVcgd8vqRxcPopXnAtKnLRGBnjf
 SOtaoxxZX45QuAqgsUuOksN2dOJDOibZQg==
X-Received: by 2002:a05:600c:1c0f:b0:4a2:150f:1601 with SMTP id
 5b1f17b1804b1-4ac1709a7bdmr458056205e9.12.1793903803605; 
 Thu, 05 Nov 2026 10:36:43 -0800 (PST)
Received: from ArchOarora ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b56e2ae72dsm136068355e9.3.2026.11.05.10.36.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 10:36:42 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
To: Sebastian Wick <sebastian.wick@redhat.com>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Oarora Etimis <oaroraetimis@gmail.com>
Subject: Re: [PATCH 2/2] drm/vkms: Use drm_dev_unplug() for ConfigFS device
 removal
Date: Thu,  5 Nov 2026 18:36:37 +0000
Message-ID: <20261105183637.188094-1-oaroraetimis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261031225901.3200167-2-sebastian.wick@redhat.com>
References: <20261031225901.3200167-1-sebastian.wick@redhat.com>
 <20261031225901.3200167-2-sebastian.wick@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Oarora Etimis <oaroraetimis@gmail.com>

Thank you,
Oarora Etimis
