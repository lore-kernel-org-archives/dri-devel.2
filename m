Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09032C88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 17:42:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31DC610E212;
	Mon, 14 Sep 2026 17:42:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="K9GMkzQ4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E8AC10E221
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 17:42:54 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2960743E51;
 Mon, 14 Sep 2026 17:42:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 016E0C2BCB8;
 Mon, 14 Sep 2026 17:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1789407774;
 bh=PUvlkcnmJaXZt5p8As0KvIuk3AZONRe1vja4HE+7gb4=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=K9GMkzQ4tXQnYcuZuo4qsEOXG8WXJfw6ehXpaMRK/ECEQ0qVPjdMj4jnVma2fyXe3
 JcyHHoDM5nG/FnjgrOs6iOJQ8V8OljpIcYqZKkqa1cIkONgUGsQ/cOkm0ZB3Q3sKU3
 K8y6SR1nPGhJ0rCjaJ9Lao8bNuI1ObfHycKP60LhZ7GDYX3w21L2ijbCN35LVYUWdm
 6KOwVAq5RsA4s0BtH9sTKZrf/+eJduzrP9vOuv8Ib9mZj2eISzAZ0ghvTDWNfk2pKo
 mwl+rCoha+9hhdR6ZdMuxd6/aWc5Nffcf3yf71ww49BzpopC3VU5cxRw/1OqyFxPbw
 i9YbeJ2D1qF2A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id C352EC88E73;
 Mon, 14 Sep 2026 17:42:53 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Subject: [PATCH v2 0/3] backlight: qcom-wled: Fix OVP IRQ imbalance and
 start from the hardware state
Date: Mon, 14 Sep 2026 19:42:46 +0200
Message-Id: <20260914-qcom-wled-backlight-v2-0-a908d9233e93@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NSxKCMBAFr0LN2rFCABFX3sNiEZIBRvloEhGlu
 LuAe5dd1a/fBI4sk4NTMIGlgR333QJyF4CuVVcRslkYpJAHkYkjPnTf4qshg4XSt4ar2mNpsiS
 NhUyjJIJlebdU8rhVL/mP3bO4kvZrajVqdr637+12CFfv/8MQYog6NiYmVRgl0jOP7Pf6A/k8z
 1+qgE5jxgAAAA==
X-Change-ID: 20260908-qcom-wled-backlight-fd9574027353
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Kiran Gunda <quic_kgunda@quicinc.com>, 
 Marco Mattiolo <marco.mattiolo@hotmail.it>, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Joel Selvaraj <foss@joelselvaraj.com>, David Heidelberg <david@ixit.cz>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1862; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=PUvlkcnmJaXZt5p8As0KvIuk3AZONRe1vja4HE+7gb4=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqqDIcJVfrVXuYj/bpDoKLOG0YCDlIZtHrntKuG
 wxZR0f1JvmJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCaqgyHAAKCRBgAj/E00kg
 chiGD/0RSVqrVoapWgon9AH1/YrrdXUVhs7NeYk97yKba4FByYxmYxUxhEyFzw3Vs3/3n37ezd5
 k2EB62/9RJUxQLTsJmiOheaSwYwBMC9NBAHUOP5FJponINw0xDfpigHOE0im7qnkzeBU0BAORH2
 EpWkzpwX6fitA8wVyeaAvN3X8XLAiht+U9aDQSlhjIhwTG6vWWdftMwPfS9OoN/7sDMhHrMysIV
 o16MmdHmD5v+gDUMtQC/UIZllBlXXWXcdb4Dt5E5znCnXQTKa+TVZhuo/ZnGB+W0erezMwl69qE
 RGMBW6W+mEzz2w5ZPO/2kjud/WYYfUFJeqBuVO13c06VK17YOa2oTWunhbAEW8rHgaGouxdCzQa
 r8gs2Q53wye/wJQKy+Nh+mfMhGo3SUiU7s3nBD8sB9Wuf+hUwhay2Hdf8FfC2A6KcK46utsg6Dm
 l/9H1iVQhgmiixrAZdJpDnrdn30GAvpS/dGdUiFZfrjom77pmuUnitnaaHXDM0oLxcn3A31RGSw
 eur/3WTXv3hhTjn3Sc8R0XocFa96rLXn/86Zxc0pC5XJ22mJVy6EBHmBQOrP9f0zm61IlH/VNCO
 2aJZ1OqRbuEAb4Zgo2/vek+YjIk73WC92wo4t5rI4Fj3KE1BM3qGSzEx5/jSThRKd0qnDHmkYJl
 ZZaJZK/5nolyKnQ==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
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
Reply-To: david@ixit.cz
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

The qcom-wled OVP interrupt is enabled at probe whenever the module is
already on, but the driver still believes the backlight is off, so the
first brightness update re-enables the interrupt and trips "Unbalanced
enable for IRQ". sdm845-mainline has carried a workaround for years and
Joel posted a flag-based version last October [1], which Konrad and
Daniel asked to be replaced by something that does not track the IRQ
state by hand.

The first patch is unrelated and fell out of writing the readback: the
WLED3 brightness register stride has been one byte instead of two since
the 2019 restructuring, so multi-string pm8941 boards only program one
string correctly. Untested, I have no WLED3 board; it restores what
pm8941-wled.c did and matches the downstream leds-qpnp.c layout.

[1] https://lore.kernel.org/all/20251021-qcom-wled-fix-unbalanced-ovp-irq-enable-v2-1-7ff115b4ffe7@joelselvaraj.com/

Signed-off-by: David Heidelberg <david@ixit.cz>
---
Changes in v2:
- Add a fix for the WLED3 brightness register stride.
- Add patch reading the programmed brightness back via
  backlight_ops.get_brightness. (Konrad)
- Note the brightness readback is done in the follow-up to the first
  patch.
- Link to v1: https://patch.msgid.link/20260908-qcom-wled-backlight-v1-1-c4dd4eabda07@ixit.cz

---
David Heidelberg (3):
      backlight: qcom-wled: Fix WLED3 brightness register stride
      backlight: qcom-wled: Fix unbalanced OVP IRQ enable at probe
      backlight: qcom-wled: Read back the programmed brightness at probe

 drivers/video/backlight/qcom-wled.c | 88 +++++++++++++++++++++++++++++++------
 1 file changed, 75 insertions(+), 13 deletions(-)
---
base-commit: 944a035ecca915ae947905dcfb03f2b9dc6d032c
change-id: 20260908-qcom-wled-backlight-fd9574027353

Best regards,
--  
David Heidelberg <david@ixit.cz>


