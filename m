Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D41CD4F52
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 08:43:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4746B10EB6B;
	Tue, 19 May 2026 08:43:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="knXrzMBW";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B2AB10EB6B
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 08:43:44 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-45d96d21e82so1884161f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 01:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779180223; x=1779785023; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FmS0AK5bqXeh0xlGi+onoeqz5lotlB7Tla6Mg7VB7/0=;
 b=knXrzMBWfsltrCV9SB+SRRjCEnKZHRTav/MG1GgL3fDCFrvJj83YrX8ZxPPIY7dnCA
 wreH1KEDeqh91xhxIlI7cRwHfYKQIFm+4vdlDEywxed+lchxud1W5mKpCjjJnOXkpvkf
 iANMOrFZ/+H399/QdbRd2TPwnjPYe3bFLl5zt4vjPgUbX9lsClXMgjC511AlfZ+Slu4O
 zLW2zdnQHbXrSNZ9jNM6Y4t72tj06Im9qvepTMf2jrwpDJXjkFWeFvAR1n6TrtPSRBCT
 wx6sAizRYp2HWII468mrbT1M31Uvj53GWkWnZYD83paDjhwITUDukVkIyQMj8COGpNmy
 iIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779180223; x=1779785023;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FmS0AK5bqXeh0xlGi+onoeqz5lotlB7Tla6Mg7VB7/0=;
 b=AFHKW/hpFjGVyRLuGmb8PQ5Oo7esdWcC5VephyC91xFKfKzhL6IUA5pftXSxnkxa3M
 tDLr9hztJJVIqZwPTd8OA2lagctWH3jQtnj9GmzQcm5Zim1pP+PnNr6LbbvTveCXNRV/
 T5nQwfUWQU9CBrlcycdVSrMl/MHEAF6zixpH+K+ntg/tyVeInT1TnzZDhuiWVTxxpynW
 l6fVSGDkPxfUqnamw2pJWkTPumJsQauxa+8n9d2Shcyp/tjac+snYL/VkJKqC3yotzFP
 i2cEzdTbroeDwHhj0Kd+5fklqgdCCF/QdS9mKaNzQ630wGZVPufYzN7Jz3sqy47ju0Th
 b8nA==
X-Gm-Message-State: AOJu0Yx/vAvXTmyONRaCRSSbhHrD1xFqGjEL9fJjKP75HD2kty5rfQCt
 caSy9pg5SWhkz7uFvbkOjHZO+0wWGpP33+F0rF9ZB0OBlmN4Y5pYo81sml9aZ/nF51g=
X-Gm-Gg: Acq92OEhj1GDIAnFpooj7GCT0jnGxxkYFxvjtlJVjk0VXnUyP/GFdKqlLSzon/LqKoy
 2YwiVrxHAgSi3+Xcnjh4+u26Khtgl66UCI4bZuelZ01sVVgdn+7T7xdl6fwPVCDWvRm7q81EpZr
 uMaEztVgEWhcmSVqS2vwOT65zRPd2ZJf+3tHA6SZ8uexgwy7MEGJC7CjPbVQPbPtZdvOdt1Fbab
 3COofOxasgJb6s5GuvbUpam6b5RTyCFoet/CMlI2anwvvmIaSoW53k2shGvOmgVZCVrRqxSrNw5
 /elbcUHHfn8gz3oqjJLwY89ObAw3uPn1xoPTm+pohue19if592LQs8JYumlg2JmdSWM5bR/SbZp
 jv73gbmAeG7SzxDkVnKjW7TBB9iVZVSFIAhDd8bQulgqpZSaKloz1dfxBQVKb6lzp9/Ht2af/c1
 guwt3XxupFH60agp6IRO9M8wR/9C2lovUW25hIPfd8HBnH
X-Received: by 2002:a05:6000:4210:b0:43b:4f86:e985 with SMTP id
 ffacd0b85a97d-45e5c5dd47amr28790430f8f.33.1779180223003; 
 Tue, 19 May 2026 01:43:43 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe1a41sm47709855f8f.31.2026.05.19.01.43.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 01:43:42 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v3 0/2] backlight: Add SY7758 6-channel High Efficiency LED
 Driver support
Date: Tue, 19 May 2026 10:43:37 +0200
Message-Id: <20260519-topic-sm8650-ayaneo-pocket-s2-sy7758-v3-0-ec8194bbc885@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALkiDGoC/5WPzQ6CMBAGX8X07JqlpYCefA/joZQF6g8lLRIJ4
 d1t8aI3PU7yZWZ3Zp6cIc8Om5k5Go03tgsgthumW9U1BKYKzDjyDFNewGB7o8Hfi0wiqEl1ZKG
 3+koDeA5+ynNZgMAiIcrrhLhkQdU7qs1zzZzOb/aP8kJ6iO64aI0frJvWO8Yk7v5MjgkgoFaqI
 llXpeDHm+mUszvrGhabI/+wCvzRyoM1fpNilmJF+y/rsiwvRIsjIEEBAAA=
X-Change-ID: 20260428-topic-sm8650-ayaneo-pocket-s2-sy7758-3081ee7f1e25
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, KancyJoe <kancy2333@outlook.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1520;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=SBsRx6COMWb8PWEHsPOkez+jZUIfIF/PVkJNqhE4ISI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqDCK8S/slQPHXNXiiLc2aYeHWz7TKawBWv30dZUIO
 Bdzq9q6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCagwivAAKCRB33NvayMhJ0XWrD/
 9ZkZGEDmabhlVXZ5CFJPKdgl4HPnSgbIpAlrs4w9RkP9cT0IDxI2J9pjhr5x4YRFpvOs6QzMB+d4Lw
 g9FlRycyhX93EgznWHgvhpvjWItJewGSwLOJ/bx+lHK4eBr4faFs/mOJsNXNtH9b5jcmO90q49sreq
 mRHdEngfAO3DMOcZkMEMQr0/+Do3r1fQd+5dfD0qs7kOXC9ZG1jCBvipyUVwWisgKMdHDILdv7sZXv
 zTE15MoylurfnE4m8EkDvTOSEx85N3Ibq4SRRz1psqLOIbhmfJ+gsej1aMQWoh6MZMlINgDXfojFo8
 CLZlIjVDuIh6+lHeW4XOC1NBh/2Xvug09+3nAUFh4MuMPFij9RTS+p1d/tJiLA+6+SCmiZn5pWgcvy
 ZIVmofvjUjEIk6B5RPmqiMvR7RbqnHC5N4FSKHRmpqgGlovDaUa7gelUvkqsLAuR+vECNP+njNU1Zn
 4pPBYMisf+g+t5tt/Uo9l0dOyCsvwmzR/kzwI91BQ2vJzSQDpfPGtEn+dneZLjjLwDl30Yk8MLnej1
 4SrZHx/dvwSYJTs5FW6yXSLRZNeL0gOZ78YnlrFXfP+t+gmUkCCwcaQPajPQ3XbMeAjxrwuw6yvd7m
 LH3MGkaGlvfSUFgi2pwuB5ty4Kn0fUnYEaGfaG1zdOl5XNv1CjonJOJS2byg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Implement support for the Silergy SY7758 6-channel High Efficiency LED Driver
used for backlight brightness control in the Ayaneo Pocket S2 dual-DSI panel.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v3:
- Dropped unused macros
- Added second autho entry to match header and commit message
- Move my signof at the end
- Switched to flseep()
- Link to v2: https://patch.msgid.link/20260430-topic-sm8650-ayaneo-pocket-s2-sy7758-v2-0-308140640de9@linaro.org

Changes in v2:
- Fixed bindings subject and removed "|"
- Added review tag
- Added higher delay before reading ID from HW (100us was too short)
- Removed probe defer if i2c read fails
- Link to v1: https://patch.msgid.link/20260428-topic-sm8650-ayaneo-pocket-s2-sy7758-v1-0-0caade5fdb32@linaro.org

---
KancyJoe (1):
      backlight: Add SY7758 6-channel High Efficiency LED Driver support

Neil Armstrong (1):
      dt-bindings: leds: backlight: document the SY7758 6-channel High Efficiency LED Driver

 .../bindings/leds/backlight/silergy,sy7758.yaml    |  53 +++++
 drivers/video/backlight/Kconfig                    |   8 +
 drivers/video/backlight/Makefile                   |   1 +
 drivers/video/backlight/sy7758.c                   | 259 +++++++++++++++++++++
 4 files changed, 321 insertions(+)
---
base-commit: 39704f00f747aba3144289870b5fd8ac230a9aaf
change-id: 20260428-topic-sm8650-ayaneo-pocket-s2-sy7758-3081ee7f1e25

Best regards,
--  
Neil Armstrong <neil.armstrong@linaro.org>

