Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF6E2C982CC
	for <dri-devel@archiver.kernel.org>; Sat, 19 Sep 2026 05:29:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E82B610E642;
	Sat, 19 Sep 2026 05:29:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O+8WWfLa";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB0E710E642
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 05:29:10 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49ccff31419so11724005e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 22:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789795749; x=1790400549; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ekSDbC6S/5AfZ2Iah9TGW0ydX/g6qRFKlYWSxfRX59A=;
 b=O+8WWfLan+u5CwuXQsB3CaimoEE5ElH1JCVcdJP2kovZUoRgKIT1C4S/rPy9AV7f2v
 JFfSGYdVbBulzc29IOABUb6GqKzFmqeRw7uH6CZ5VJwI7mK8FCMb78zNYANM486B53MC
 +a1fN9kGLEMgZtzWQ+k9+lXAXaZLFCkDIdiORy98At53Il8zLGfnAP5RWjTtfSudK584
 f0WkiishDvNQvJycz31kfeyS4MspXlgN4iftNbR3pBTQDSZwgFYUjmFrEJzauNNYwpRZ
 pbib1vEYJX7GX1q4laVM8HOdB8eOYtRsUgSJyCogBGWBdaIHO0KgNG39MAUwBt+kOobc
 f4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789795749; x=1790400549;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ekSDbC6S/5AfZ2Iah9TGW0ydX/g6qRFKlYWSxfRX59A=;
 b=gaJsnbB690obgYhtASRzfUT+j/QqN1JsvFtortafq28J6YAH3JW+D/QQ2U04oZaP5v
 4iaYA7UHFZbQ43ZQznnecg259UTQSlLn79d39KEB8VQE8lKtDtpDeAoOfrBQ/axzJg85
 zBRFo1bFa/h7YT77NxNyvkVcesGqyeGYb2TREwbv2liP7IOg1PDDqGrTLy8zsuEyDYZZ
 nrNQWCL0VW4IlZphahRqCmVMgEpq5KQcKTDMjtguFzTPNl9qiIeolP+ordPimalobbAN
 sIgPUleYPy8Q7qyJP1XgJDRN6mOBdg9ugAos5uN1HMzcuGYPF4elcw3PsfDwcqWqe1k6
 q+jQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz1rzAG+PZSTNFCWowTRYZbmNn3NX/E00BxwLc2S4Y3+65u0JTSrpoK6pRa3C4idh5KIxepz7Rr4Lk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mRHc5o0ebgkLq1kgwr6iQXfD0BIg9HSsOZH1ggLdE27YNyJtuS
 sHqW7IgYBSzMHTHI32mzNHfdUD2hbeEfQFA2/O1yzO4y5OmLnjphGCvE
X-Gm-Gg: AYBFou0fdTEuczRYNBklFCQPfU4BS2D5rFW8C6p/QVB0pkAD6a9paey3JcsaTZSYMLY
 Tln/qyi69tmVedCH70NtLbnuR69HyJF1nnoSG/zJNArGJRzkKAIujjUDLJivH8unmjExpyUrlSC
 k+afWOYUSwzyl8lXztwznGopfknSDtc6FbqnZ7TtQOQVikd0t6Z4A+uGoTtDz3Mul7ZgDSAi8bZ
 b66FZea37OC9Top8M7c5w4odMTkemI8jzSqODW4YnGzQW9V8gGQ5speNpyR6Hs1OS1FFawO0sLb
 uSZFSf2xR27wLzhva7XaNqvXka4dGVzbgUgNQ0QEpwdDk6yJw5H4xbCR936dnkqV9WhVYYzovD4
 N+/zp4kL++TnDUerFtO2W1hcWg5rBeCS1gpkNnP9cqoCFHaTgjysGx0b9ZbPszuCkQ/5JB+cJ6C
 /+0wWo8lGwERjvf6JZFX9IfzCCQeRPN/DmGjOFFWl/SwjXYCdi3mTb6hRaKkR2ECtebnA85k3yj
 fEToZZ/U+Sewgmhk09K4tDxLN6lFiSMcTYsentgUXYUzBywUgIfn3DWW5cAKAmzANEJn5efcGYX
 gDu1ZnNOPk8hGRuSQ5HFvw5uLy32QLwQhHUDFrHN5JIZcvRXZxh0rNEe8ovnHUaK8WPVACzvHwt
 U2exmmjVnxs30kbqk
X-Received: by 2002:a05:600c:3b05:b0:49f:c196:47b9 with SMTP id
 5b1f17b1804b1-49fc567318bmr60705515e9.4.1789795749070; 
 Fri, 18 Sep 2026 22:29:09 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain
 (dynamic-2a02-3100-a017-2b01-05fe-203b-7cd2-a640.310.pool.telefonica.de.
 [2a02:3100:a017:2b01:5fe:203b:7cd2:a640])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4872459d409sm4258691f8f.33.2026.09.18.22.29.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 18 Sep 2026 22:29:08 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 linux-sound@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] drm/vc4: hdmi: Unregister the ASoC card on unbind
Date: Sat, 19 Sep 2026 07:29:05 +0200
Message-Id: <20260919052905.26038-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260825063735.14676-1-kmehltretter@gmail.com>
References: <20260825063735.14676-1-kmehltretter@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Tue, 25 Aug 2026 08:37:35 +0200, I wrote:
> Register the card without devm and unregister it from the component unbind
> callback, where both the HDMI device resources and vc4_hdmi are alive. This
> makes the card lifetime independent of when the final DRM reference is
> dropped.

Friendly ping on v3. Is anything else needed from my side before this
can be picked up?

Thanks,
Karl
