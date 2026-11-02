Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7618660A2620
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=nT0cfwrs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 495A210EE65;
	Mon,  2 Nov 2026 13:40:47 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CA4A10EE4B
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 13:40:38 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a2d6d01ecbso19164475e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 05:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626837; x=1794231637; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ijcQqp+PDwh0iYp+MD/r/nuQr1SB4jBOpcMmhui2GqI=;
 b=nT0cfwrs+mr7Mq1txCawCq0AsaAJjTGmJSEaHKNfLMEUJMc1K73icmGmK5NmR2g06z
 3pkO0GgoA9piJoO2GnbOuflz/Fu7W9kp9XX/CLhob8UkVm22WvSvvQcu2PwEmEFcFRdQ
 GewyHXZyi5wBqWCoCK4svxXY1rWXAFtoZyhD7L+urZ1gDywzkDUljqGJBqydF+tyVXSz
 lGYMOJg+xeGwSSOygtk6l0lV/fuaJDbfDNzXE6Z1KWTaDtO1wqGsO282ylqSvu/Odi5D
 qTHL2NGcnRWAlqbSpBHCcRfAUsFoyiODQlXuHA6aFvkDEIO4pTH+aZxUV4RgdY4ju4nJ
 hSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626837; x=1794231637;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ijcQqp+PDwh0iYp+MD/r/nuQr1SB4jBOpcMmhui2GqI=;
 b=Ux69McJQG9986vlDtnO3Xz4Lg+S0t24uybd6SFP8r0y0Vu/70efisszFrBEQVCqFRN
 CGAhaejauIz9Qk3U0EhSaijOtXK6HHHieJcAPUs6sMKDgT6VzNDXKRaBUP/QFe0J9YDI
 zuxT7Qf+JKtvBDxN4jmROUXcR2qm4AQVXGaLf9PG8qWojFBN0LL0O8+obXkFzEyFn6rQ
 F6yfDD7Ou2Bcw/1Xs6BZlWDjK3U5dk9SPQCANa/PocQe7cvXAVMVyLbUKFG2o6ofv8rh
 Z93NctX6+3uS0t+/CJ6OIRwqEQfPPAtZRm7i9RMyzl6L6WT3hMKBb/v9T7kJpDpyqV5u
 KZiQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByeAZcimTjMSIpNF1Ns5lD5Yluajs8xvwyZjblEQoyO9E20blcpKpF6J6W4N2c/TPh3z4s5D5LV/VE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIL39xLThq1DuQWfBYTocSHuVgn+B9R2cI9wrHMxfNNsmpjFqjg
 l65EaCjK6WidR0xh1XuABq7gNvBB+RPQrYnVhHB+eLjLCNERs5E8Ap0yXITwAUSzEkI=
X-Gm-Gg: AYBFou0rl2kv9nkA5HgnboTrxLsf0k7T3tDZWY+YW4wKWa4aM/VwYp8itzUWS/uvNbs
 mzHNOszlyWGzUbFSoa8BACHIO7+jg3V3oPmDxkavvJctIouiNKuEEfjfG71D4GGzdmqFU5yeLkP
 svGjMiBBh79TgesZ5x5r2zKlkSs9i84t9WoomH8FasS7khUvUq2yoA0NCxPy6Wr3nJnMCXjl06t
 AFicq7H+DtXH67qaElk+JmPmBLLzsgTvjYNt/HdGXfgymkMsVGP9QEPLvbpB66TB2fpJvJRqvqv
 0+8tczPWU139FnYoeHI0RQ/z7Gjpvks5JA6wgt6z3kCOYUMAPdcKxHrOVEQB01eDkncamyJNOu+
 i/h/IGeAHFShqPy89LDebZzgoy5FFFhbktA0CaRAv0tjQ/nXAQ8p06rfo8NSzUO4WYTiw1+VOta
 lzy7H8bLpm6pG2P8zYAQFzFl3J/r6HrKGe0lyNp4Y6cBzmubky3XTnTCZky5iejp1NG20B946sG
 yJRxqLy/xCsVHB0Ep0r29UrHcxZkEqBMXPNaUKsy73YHzhatVRpKMPOPoq9swCu+4IHwC432EFX
 q/uUt3zFKcDpOY2O9+rh1ofofe3k8AaEYJUS4n6Zq09xmDFyzg==
X-Received: by 2002:a05:600c:5397:b0:4a3:5991:719 with SMTP id
 5b1f17b1804b1-4ac1899353bmr229794415e9.31.1793626836593; 
 Mon, 02 Nov 2026 05:40:36 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abea533a1esm189194605e9.1.2026.11.02.05.40.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:40:35 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jerome Oufella <jerome.oufella@savoirfairelinux.com>, 
 Felix Boucher <felix.boucher@savoirfairelinux.com>, 
 Quentin Lehoux <quentin.lehoux@savoirfairelinux.com>
In-Reply-To: <20261006183455.2350966-1-marc-olivier.champagne@savoirfairelinux.com>
References: <20261006183455.2350966-1-marc-olivier.champagne@savoirfairelinux.com>
Subject: Re: [PATCH 0/2] drm/panel: ilitek-ili9881c: add support for DCLTek
 DT300249
Message-Id: <179362683550.3310106.10835901197698489630.b4-ty@b4>
Date: Mon, 02 Nov 2026 14:40:35 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Tue, 06 Oct 2026 14:34:53 -0400, Marc-Olivier Champagne wrote:
> This series adds support for the DCLTek DT300249 5.5-inch MIPI DSI
> panel based on the Ilitek ILI9881C controller.
> 
> It documents the new compatible string in the binding and adds the
> panel descriptor with its initialization sequence to the driver.
> 
> Marc-Olivier Champagne (2):
>   dt-bindings: display: panel: add compatible for DCLTek 300249 5.5in
>     panel
>   drm/panel: ilitek-ili9881c: Add DCLTek 300249 5.5in display
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/2] dt-bindings: display: panel: add compatible for DCLTek 300249 5.5in panel
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/342542e4ccabf8e768293eeab4c4b43337708a54
[2/2] drm/panel: ilitek-ili9881c: Add DCLTek 300249 5.5in display
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/164ec23bad8e3885b7ff8b881190d162feaa32dd

-- 
Neil

