Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83191C5B572
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 19:58:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FE6910E353;
	Sun, 16 Aug 2026 19:58:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="Av7Tesgu";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="R3JewFIL";
	dkim-atps=neutral
Received: from flow-b1-smtp.messagingengine.com
 (flow-b1-smtp.messagingengine.com [202.12.124.136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B652910E351
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 19:58:44 +0000 (UTC)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailflow.stl.internal (Postfix) with ESMTP id D959E13002F3;
 Sun, 16 Aug 2026 15:58:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Sun, 16 Aug 2026 15:58:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1786910323; x=
 1786913923; bh=XnBStf3gY35JgbeiLlY3OyQBN22mjeVyLGOlqZ8Olm0=; b=A
 v7Tesgu9KkldXPQiDym0PZqnbClXw4HR/76tMtifOgpm3PxQ2jIS7MSBxxwrSDsM
 kGC+Ku0h2W+bOd7LMayA0jz+OCLzV9YKIJYCOCFAyEV06ew0XeS1RKuqcszcvxtW
 StXw0FlGBHFOJh/tsFiGyFXJtNdOpM7W6bP3uuqkfRjQ4+PmK1XCyaQlmO1mZcq0
 aiqdkY5Ex0yU12p+VXA8N0wL617CiEnFKxnzQG03T/LJG6PJPP6yeArLlghnkmMV
 15hdeqD7WryIElretzrb0gB1NsVFr/v6wIu+6Nal4qVXlQZ48TCY8gc8VWpLyKcJ
 k6LEE0wO29McilmNHD6Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1786910323; x=1786913923; bh=X
 nBStf3gY35JgbeiLlY3OyQBN22mjeVyLGOlqZ8Olm0=; b=R3JewFILGvZjSj+9X
 jU7efgOYjE9AiSf70wqr3iqnTlZuZgy28ljQ/RJDGkHpBjNgguVBq3swfLcAZgZ/
 g5Rl7Bdvh6phHDb3xgq3RUCQCXHPeYUvLNfOQBU4N7E0/+TZdUt+4ujhhM9oJgT6
 wHgrujhc6ZwtAdS/SwpgAs70rWXa37HRi6h2s4YIna1yyQF5h4dHUMnFacfhzUmM
 MB6B+wP9QrF4jYWDCybM4gbA3Orja5BD+pdgE01vruZ/BdveDNgZPJbgQruamien
 N/nGQXCLnekXnrersn+8AiZ5GEDfoGfzxLj92cyTs5CYVFxm2ZkT54yHejpY3H/I
 bBd6g==
X-ME-Sender: <xms:cxaCalrKA_EFNYHkr5PAX2Lu_aGKB1rN4UhwviaA_v0JA8jbg-5odw>
 <xme:cxaCav0U1F-cpevEUC8ie0AkNeWK5uGT89ZP8MlSNgeyZBL_VM7pdtBGcLk7N5Gu5
 sNQqh9fu_vFPNQwjSPkiS81750QVihmC-XccO_-WyUBqwJXhVHRzUiV>
X-ME-Received: <xmr:cxaCatz_3qD7zxzycAcwO_WM6VC98ocj4vLrkGEhsRIn2MRuVfqeMQs1rNYtk7vb52rEPQcV-A>
X-ME-Proxy-Cause: dmFkZTEdlirJvxcfGQ+WBsgr+9hxCRNQxQEcOKrpxNyi8WDOAmXAzN11cnXB8HJmbqFqBS
 xtc1oy/Jvg5YFuB5a7cM1vsDrKjpvdxzHL6eKsttkvr9s9qnCehwuQTpcvoXKqfspIfa41
 MbiEjZ/21VO49M+isqQxz7pPASLn515eeGV7RKRRWuUUpFxIxSGHJj5mAR7awOxSxLW7SH
 cVURYyNhn4osDEuqsFDw3SRG9pRa7ZHB4foIEOnpWn1jjexsF7hLjKSn8/ETyRaaurqTEr
 GoOKat559S2zZQp5qGm+OAZRKYj/jLwCA3ic+UZsN91e8thYkAa9MjE+dp9RFBpM0UTcLE
 Jualy7VLSaJv/6beoFPaIdHkpHfFnr+SYl17ZX8EQH71m8HlmWHiFRJVW67ofJWnhbOET4
 RGoeLRm4c14OiQnLxgJ0xDORcWxXh/NfS8395LJ4FYRSrLz7WsCfzcHrqMEn12oAJrwWmI
 cwyyzHGhvsVD9nLE2g2W++fdrJFetqqGM0pFnGIrFjy8tqhZwuqBYl2mx+rfP3Wi3W9KxP
 wBmv4wn5jr9gs6un++qLKuXf545nFNI+rcPO3bKMHQW3n/Iqpc5WclTDM/7OhZIZDlB79V
 askSqi8M032Jc3s12ziNS6JfshhQCnj773P5fQqZMD1DwR03Ya7TawCXfXfA
X-ME-Proxy: <xmx:cxaCargeG-LqeC9k-KyXokMlhG5cJjKWK7nMnO_4rdV8bai8aMW9gw>
 <xmx:cxaCagqoE3ylQ0UZMlNjGBwYGHxyjjW1Nlc75MD-EIATG3Z3X_HCVw>
 <xmx:cxaCaihbdAlK49ddmJ7Yo5sVosQzCDk1jt8BKKNn74GVqvSgE3A4rg>
 <xmx:cxaCaiPbGxljNVevn3sws6NPuDfAezQdtMh0tXpx0ba6gX-hudrybQ>
 <xmx:cxaCamIPlp7D9jLXir41S3bfCEN_jPhrVybyr9xNbCqZEuTAYhmyZrEf>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 15:58:40 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: royalnet026@gmail.com
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, chaoyi.chen@rock-chips.com,
 alchark@flipper.net, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 08/10] accel/rocket: add RK3576 NPU (RKNN) support
Date: Mon, 17 Aug 2026 07:58:37 +1200
Message-ID: <20260816195837.497735-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAEWPSH54fhzKEYR1cgTskNgKryDEMaZOY1y5aFdKQQyzfKbYfg@mail.gmail.com>
References: <CAEWPSH54fhzKEYR1cgTskNgKryDEMaZOY1y5aFdKQQyzfKbYfg@mail.gmail.com>
MIME-Version: 1.0
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

Hi Igor,

You are right that it is fitted, and decoding it against registers.xml was
worth more than the fit was. I had been treating those two words as opaque
constants and comparing predicates, when the thing that varies is one bit.

Your reading also named an experiment I had never run. Every measurement this
board has produced was of the value my predicate happens to emit, so 16 and 41
output channels had only ever run with SIZE_E_2 0, and 56, 64 and 128 only with
1. The cell nobody had filled in was SIZE_E_2 1 at the small counts. Forcing
the constant fills it.

  output channels    predicate     forced SIZE_E_2 1
   16                16 of 16      NPU job timed out, 0 of 16
   41                41 of 41      0 of 41
   56                56 of 56      56 of 56
  128              128 of 128    128 of 128

So each form fails on the shapes the other handles, which makes it a two sided
measurement rather than the one sided fit it started as. Taken with your RK3588
result, RK3588 does not need the toggle and RK3576 does, and what the toggle
selects is SIZE_E_2 rather than anything about the channel count as such. I
will write it that way, as the field with a reason, rather than as a modulo or
a parity of something.

The other bits you flagged I cannot defend yet. RGP_CNTER 8, OW_SRC 1 and the
two in the reserved range came from vendor captures and have never been varied
one at a time. That is a sweep this board can run and I will do it before the
Mesa series goes out, since a value nobody can explain is a value nobody should
be asked to review.

On the unclamped reference, thank you for using it. It changed what I thought I
had here as well. The clamp is only free where the quantised output range
starts at zero, and on a middle zero point layer it rewrites about half the
surface. conv2d-cal is out_zp 128 with no fused activation, and against the
unclamped output it is 0 of 128 channels rather than 128 of 128, with the
hardware equal to max(cpu, out_zp) to within one everywhere. Where that clamp
comes from is still open. It is not the output offset, not the BS block, not
any register in the stream, and not the coefficient records, all four measured
rather than argued.

If you want another shape, an output channel count of 88 or 120 on RK3576 would
tell us whether the toggle follows the same rule up there, and those are exactly
the counts you already have on the other SoC.

Jiaxing
