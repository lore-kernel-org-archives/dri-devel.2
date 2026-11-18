Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EF4606A324
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=If6/L1/a
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A647D10FDBA;
	Thu, 19 Nov 2026 07:49:12 +0000 (UTC)
Received: from mail-4321.protonmail.ch (mail-4321.protonmail.ch [185.70.43.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A696B10FDF9
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 16:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=michaelmcallister.org; s=protonmail2; t=1795017209; x=1795276409;
 bh=Jv01MUGM1QJuBnHIB96rkf7JnQKaC3rvwn7e76mZ8n4=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=If6/L1/afFXCFOtGJ5apCOIEmMufwwnk+b9k7kvgXkpk5p31wR2WE6VO5/MVixibe
 MdWsEdJa0KhAVCSoNsi0d4aydDWiSS99UU7Q2oGUFGcrD4YJMUMbASLglCTWQie2Ri
 PeXmZaF/cNjnNt170ritfAFcAGUTlnCeUFUkgKqpuMJrWOOBgNqpdtqHAdKkKIa5D1
 KQb4IKHHY1kr92N1/akNzsyPEGLFXRnhqigYsUbJvp//pOVNncU0yQJi9LDSVNtDnh
 lQ1XjlskHIin9RCMWAePYIfG37GvVRKVgeJ6paqDOJmEGGBl0NvPciJCfWJHlw8lMC
 grOvDNpC31opA==
X-Pm-Submission-Id: 4jV5jc2TRTz1DDXX
From: Michael McAllister <me@michaelmcallister.org>
To: tadilhusrev@gmail.com
Cc: neil.armstrong@linaro.org, jesszhan0024@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] drm/panel: add Novatek NT36525 (Samsung Galaxy
 XCover5)
Date: Wed, 18 Nov 2026 15:53:23 +0000
Message-ID: <179501720308.74840.10845458526829767554.g10-nt36525-coordination@michaelmcallister.org>
In-Reply-To: <20261117173319.1852638-1-tadilhusrev@gmail.com>
References: <20261117173319.1852638-1-tadilhusrev@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 19 Nov 2026 07:48:39 +0000
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Adil,

I've been working on the Moto G10, which uses a DJN NT36525B panel. I
have a local driver, but it'd be good to share yours where possible.

My panel is 720x1600 with four DSI lanes, a different init/reset
sequence, and DCS backlight control. Would you be happy with follow-up
patches adding panel-specific configuration and G10 support on top of
your series? I can prepare and test those.
