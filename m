Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D017606A33F
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 12:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nN3cCjZM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5260B10E7AE;
	Sun,  8 Nov 2026 12:32:41 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBAA810E7AE
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 12:32:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A50BF60D4E;
 Sun,  8 Nov 2026 12:32:33 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794141153;
 b=TFkj5b/nGo6xNY1e7zxyQ4VEtSWUZzHNVm4pjVETAwOPRH8tghOehi+/SLu6LjOOUdBn
 nCUcyiMlZfuhx6Fuzj1AtndVd+As0uSYSsZSkVnbW9L3sfwYRSlFCYgZByDGKqRA0Xi77
 BDsj/kgPjbVA+lK2OYpwISnghuogD64Ew8jlh45ZjLJjMl7Jpns/im+tSByuVt8WwhN9k
 kFxcABofVXLKiIZkhe7jed1Q1rqx8KS2iCuewg4qWdKuMTYVqwHH5Bpsjj6B3HBNPd1Pj
 x3uXq86IN5YDy2/yDiAbzW4YqmSPxmBp1f5i8VM1IhpTiTDugHakQONndtNo6lren/w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794141153;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=xOoQpZg3X2a+CkR5aV/9WieWfrkjfNlxLxvKZGfWUyI=;
 b=S0LHlYXBemvIqvtXhhDSO6h8JXyb+PCm2bL922Gt0mrljIURzELFOkoZDcihcCSDlEIh
 ZTw57El5TFwiRvoMLKSpktl0szlENL5ZWlF4uBZqx86PamQN042xrakSQ225o83k6KAnx
 nna0CAbX6uzyd+CBt/EanW0Zhk/mUjg7gKFD2LRwOF4Vf8WOgykaaueF3ogEueMYyxq5q
 /HQw+0AdmhwE/6FQG819r3DsLn3aF/BdvZET/oKe+WFqG4R2Qo6dfV0hYcQJmr7bSlcrC
 M+ig4osCVBuiGmpCexlugJ5Ye2WzqQKJIMj6fVRJjuSpSUcGS4mMTZWORnrfmXntQsw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id BFC041F0089F;
 Sun,  8 Nov 2026 12:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794141153;
 bh=xOoQpZg3X2a+CkR5aV/9WieWfrkjfNlxLxvKZGfWUyI=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=nN3cCjZMSPRw6cvAn4OxC4s7acBIJNb9ZBbxaH8zJB78NR2yAtVRLIS+HshcwhT2/
 mz8+s2Hp1WGYUvEZBfKoG4xd+VCWHt43peGxjI82Fo5GQnBl8HSXi7W3Tpj8oWT7tM
 u4m2xAvN4BPPD7V/xodRBzNq4Kj5/50kJSThqtxhfgnPlMNusZTrPw6nvZKANyoD8l
 8XRGIVLTKd1oWWkQ42JhRr4GmhwFwlHwKCD6K2lbgLMN1cP3LBo7leLs582aNkWHy8
 j6ryyXqpGMEsXNSSif6ZepPjAj0ktqa8+gAHBNvZexssAUVWaf+sp48xf4KKAEoJ2M
 knEwyiL+8xM0A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 2087847F65;
 Sun,  8 Nov 2026 12:32:32 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Subject: [PATCH v3 00/10] Pixel 3 XL display panel support
Date: Sun, 08 Nov 2026 12:32:21 +0000
Message-Id: <20261108-crosshatch-panel-v3-0-87dd4ec4f7cc@ixit.cz>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQ7CIBQFr2JYiwG0tLjyHsYFhY9gTNsAkmrTu
 wvtQhNdTvJm3oQCeAcBHTcT8pBccH2XYb/dIGVldwXsdGbECOOkIRQr34dgZVQWD7KDOyZcQSO
 5MG1tUNYGD8aNS/J8WTk82huoWDplYV2IvX8un4mW3ZoXjPzmE8UEa+AgKsq0FPzkRhd36oVKP
 LFv/fBHZ1knja5U3ZqaGfXR53l+Az9P2bP/AAAA
X-Change-ID: 20260801-crosshatch-panel-06ce8a69fb7f
To: Dzmitry Sankouski <dsankouski@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Petr Vorel <petr.vorel@gmail.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2412; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=tSNDj9ymd4uYRUtBQHQkxmD4lJDASY/5ynNPCLRIiEc=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBq8GvdnBVMxF6dVYBg04KasocW7b688c6Q1Z7Ac
 SqHVoGejyeJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCavBr3QAKCRBgAj/E00kg
 cuw+D/0Sbmtnsb/VzdAqegSnnaK53qakB/RaFB0UcpvX6DlP3yFMUkNM8iEQUkgjFhIjE7ZMYXs
 URqQI2C5vxRsQS3AvXLigIZF2txNuLrwA1w97NN5JQTg6gznbkg6irKg9vmQjd+Hjo52wOLjpeo
 lkosvMUEqAEJUe2csK5QrucpYLMx0kTzD96ECNEG6IvBXZ2luzKxqR2Hjdb5zuS9PfxXeN6QvFp
 0ff66Djt0FjwasesIIaqeM9zC6Dn5moZQI5ivzEVSEcWwo30+J+ss0rLdOilx94bfyOonHiIcMs
 782nx0mQ0Kfbe74rdeGTPsngs8HsDRg9w1HjCW6WPkge7JZLcxRLxvsTKoWRqMGKg/etWzKME0c
 KiCm8Ju2kPdTp+EFHKjHxNiFXL/CZOvQYyro66xznR0+geztQf4W3A9Vlj5pHYIEAYcKSurjg6t
 wLNs7Y+haJh7GkQtycjZ+O8RVu+xoiRwOKimf0zcE6h7NidCGReyDOoVMAZqYob5XmYQGpk+caD
 XUOVqlYfvhkWXjNjzwX8T1Lf1adnOUabQMh51uIwM6h7PSzWHqMU0btSjgLP9ZVJV7Lab84DdeJ
 wlhch6eSb0R6Lk7Jd54goxFaLmnfbxEKUljY0H6ijhERGJPGIApsQnDfDNKBgvX3Tea78RoudoB
 irE/8n65evHOMgg==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
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
Reply-To: david@ixit.cz
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Introduce Samsung AMB630QY01 (Google Pixel 3 XL) panel.

Includes refactoring and improvements to the S6E3HA8 DDIC which is also
used by Samsung S9 (Korea version).

Patches 9 and 11 switch to the new compatibles, so they must not reach
the qcom tree before the driver patches land.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
Changes in v3:
- Entire allOf goes after required: block. (Krzysztof)
- Expalin dt-bindings changes more explicitly. (Krzysztof)
- Dropped "Really assert reset on the failure" as requested by (Krzysztof)
- Not addressed: "No, this is wrong. You just broke all the users of
  this DTS.", due to non-existent usage outside of Linux and DTB for
  this device being shipped always together with the kernel.
- Link to v2: https://patch.msgid.link/20260924-crosshatch-panel-v2-0-08d5c7bf72fc@ixit.cz

Changes in v2:
- Rebase on top of next-20260923.
- Cosmetic fix s/Cosmtetic/Cosmetic/ fix in the commit msg. (Neil)
- Link to v1: https://patch.msgid.link/20260920-crosshatch-panel-v1-0-de6e9512da96@ixit.cz

---
David Heidelberg (10):
      dt-bindings: display: panel: s6e3ha8: Adjust to reflect the DDIC and panel used
      dt-bindings: display: panel: samsung,s6e3ha8: Add AMB630QY01 panel
      drm/panel: s6e3ha8: Introduce AMB577PX01 panel compatible
      drm/panel: s6e3ha8: Prepare for supporting multiple panels
      drm/panel: s6e3ha8: Correct the polarity logic within
      drm/panel: s6e3ha8: Assert reset GPIO in unprepare
      drm/panel: s6e3ha8: add Samsung AMB630QY01 (Google Pixel 3 XL) panel
      arm64: dts: qcom: sdm845-samsung-starqltechn: Update panel compatible
      arm64: dts: qcom: sdm845-google: Move panel pins into common
      arm64: dts: qcom: sdm845-google-crosshatch: Add display panel

 .../bindings/display/panel/samsung,s6e3ha8.yaml    |  56 +++-
 .../arm64/boot/dts/qcom/sdm845-google-blueline.dts |  18 --
 arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi |  16 ++
 .../boot/dts/qcom/sdm845-google-crosshatch.dts     |  60 +++-
 .../boot/dts/qcom/sdm845-samsung-starqltechn.dts   |   4 +-
 drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c      | 304 +++++++++++++++++----
 6 files changed, 372 insertions(+), 86 deletions(-)
---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
change-id: 20260801-crosshatch-panel-06ce8a69fb7f

Best regards,
--  
David Heidelberg <david@ixit.cz>


