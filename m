Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFC4606A320
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 17:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OPcOmGky
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78F3A10E601;
	Sun, 22 Nov 2026 17:13:43 +0000 (UTC)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE55110E2EA
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 14:14:30 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-372bdb942dbso1244933eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 06:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795184070; x=1795788870; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yKYud9p8+aP8cT7V12zkUbmCop1ErkdHEczU+hWaU/k=;
 b=OPcOmGkyetyUaChSYoaesWd1kKOyDwpuf9SxNSgnRCyJZVkgojuii5i/NCCsTYd2MO
 CIwyW8m26HhA+dW/4Cq4pLNTOPOZy1IwOT7wThumY7ymSjSEafxJifB2tx9hMkEa04/f
 1mDPOUBbIHHzT/tQmgfHnPmjccp8rZOaFeLny9BCiE2W4nrDJ7haurVuEcgAstVJcVbH
 TqynB+Fk85mVoBK9w3gt/xv4a/rUTki4udHhH2l6Q8+BLpYIb0hQgdFO5dVt//r/r05T
 O6b3/QgqnyOBDPzSPuasyIc+dvfRMF42MIi5lOla5bI5I0mjjNduRr84CM8DgjgyZR05
 onGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795184070; x=1795788870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yKYud9p8+aP8cT7V12zkUbmCop1ErkdHEczU+hWaU/k=;
 b=KTMoUxlPJZgzwyHgOJu3sSisfcERbCmvTvkaQ12sObP6hbXfcTXyfr0QIsuWTw/3d6
 mtuqiBStUZyDybxL/PER+t8Drks9SblF+LcQwBBuM/nRXU9GDYbmExC7x4UNQGrqhms+
 89yoS7/a/D0/AqLthr85fdb7UGwtHmzQzlYdLi63Z9+s/NgJeOmIqH82FE35c4YwKrmC
 2O3mzghCw4xF2mR2X3rCHGirxNEUR/PX05FQoIhd0UwC7F2RYYAeeLlgISx0sG8nd3KR
 +CIylFYfR8LRD+sl5JdPOGxbJq2i/qm0OJXMypc3ekr4RDl1vjIbI0pvaMduP2/mbAS1
 zPiA==
X-Forwarded-Encrypted: i=1;
 AL+hErHSPqguLdV3lRZIgJgtbpAcAtsed1HXVktMBGSNH8hafFNhojbohFuVTxT3gwhEToGmEkgQsYz88ds=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+mdhgp8oAMLFpJBp9VxiYVsiRGdiBGaTIk8jl4/vxE0HH3q8m6
 gmQ1/rBnLX/ZkDvAj8S1hgRXVI/UdZ0Z8+TsEST82zhs7fArjzm1rR2L
X-Gm-Gg: AZFdTZfHWj5pcvgaqx+CiAbHnf/kq721e4qCyzNcu7/CAEEwRx9gvY85w5DIFbMy7f/
 SGxsVPfV5YnhufYlIK597pPm//Ih9Vl62/FlUz8QQypDXOM5EALpKUVU+N9FqDVelG1/gXofNyA
 1vUixykLNv/XjN4upZvB3FarzvVtgnMgh9wFhHpgAsj1rty3MTka1tb+oQ0iL1t6RiH91EFCCew
 jr8afzN/M3nKSt8pbVvfRF0ixFviPQczycNqfwKpsu9qnGD0tzrtcCeGd/TH4cEWjEoGhYry/Pw
 +bs4NF3NO67EUiZBeV9vI+w/H9/PVhj/DCmSrpdiJQUm0mCiBqOVuPYWF25MBYRrViwtIhAoCcB
 XAAfcC/E5WbNq2e7vQEHPI0eDZovTLcyWIBRbFLSWUm04hmOq48U8gw8bKlYDHkuUr1XYSgT6w8
 G2cHXrngUpg0Yone/VQo+P4x5bTGWLITa/dsSXDYpJIFNzSSn4AR/8E0BE3cJhgvBviQizDceUu
 Ki1cHKvhl45jt1xeEn5j8lyrAJBMdKcl4ryaVEhJXjweH1EB9cwWDqX4v4EFSrEn2mdHUov3Ze0
 Nb4thI3oyldilXuarXHCD+2m3jVpjgaFatXy7XWYiKP6W7S6PeQ=
X-Received: by 2002:a05:693c:87c2:20b0:36c:dbac:705d with SMTP id
 5a478bee46e88-3856f65a86emr2607885eec.15.1795184069954; 
 Fri, 20 Nov 2026 06:14:29 -0800 (PST)
Received: from localhost.localdomain ([103.179.231.88])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385666e7f59sm8954893eec.6.2026.11.20.06.14.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 06:14:29 -0800 (PST)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: vkoul@kernel.org
Cc: angelogioacchino.delregno@collabora.com, chunkuang.hu@kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
 mani@kernel.org, matthias.bgg@gmail.com, neil.armstrong@linaro.org,
 p.zabel@pengutronix.de, sreekuttan2156239@gmail.com
Subject: Re: [PATCH] phy: mediatek: mt8195: Check PLL driver setting return
 value
Date: Fri, 20 Nov 2026 14:13:59 +0000
Message-ID: <20261120141359.2532-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <179510544374.1370333.8388939289479267591.b4-ty@kernel.org>
References: <179510544374.1370333.8388939289479267591.b4-ty@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 22 Nov 2026 17:13:42 +0000
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

Hi,

Thanks for applying the patch!

Best regards,
Sreeraj
