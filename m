Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE00C61DBD
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 01:49:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68E3910E0D8;
	Thu, 27 Aug 2026 01:49:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="Tqhu8Mzj";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="UwFFCyPk";
	dkim-atps=neutral
Received: from flow-b2-smtp.messagingengine.com
 (flow-b2-smtp.messagingengine.com [202.12.124.137])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CC2610E0D8
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 01:49:29 +0000 (UTC)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailflow.stl.internal (Postfix) with ESMTP id 892441300135;
 Wed, 26 Aug 2026 21:49:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Wed, 26 Aug 2026 21:49:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1787795368; x=
 1787798968; bh=TG6rkH/5GmXdEBSDg4LVnP0MS7M3TWqrcaZgwvPq9YM=; b=T
 qhu8MzjzxLpXavRSl1dJG4BgBxbu7XSLzhgdV1RQ9HQmOXEtp62xQ1pV3XnKRs/u
 ZxY7To4wok2DxR4890mo+ArIDYv7xs8j1RLDxE12M05oQf55+GyehUzsOifGQhmx
 mPOeLEENqiQN2cKva2eWeOZ7wvGXtvEGp3W4L+2ptCFZdfZ6kA5nYVYsx8oIHhM2
 SAMMhoXRzwegotz+tbmjb8IhO1Ax+mtCv3/9G4lVxCu5L9kUh2xo2EfNWmma4Ihy
 QR49ovkgXqe5j/jjrBvm0f6zcu/CJDLORIVubKQiqpZx9xRnxUOvkA6IKWj99B5x
 WT9GmOCG2XdumOCSo7FXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1787795368; x=1787798968; bh=T
 G6rkH/5GmXdEBSDg4LVnP0MS7M3TWqrcaZgwvPq9YM=; b=UwFFCyPkV9/Vv1PHS
 76E7ZsMJ5rwa6NYj87moyKIFJEEm3aEvqRl/cFQwfA08lvsUzHCMJTjWMokjcYx7
 TfTz/CUXNEeyivkYLHQ0nQyDtaINAGWredwoRjlBYgV2nWhF2i3HOgoQ1AX+IscQ
 nKu1ob7SE4rPs8hpVWTH+XhqicMediKCT7PPCqWLNkgqpBek9fYaIicwBcte2pXf
 OTInUjjTfxtqezCbyPX2eRrEB1sGupFk1BZi+/2gXVmp6JU+O06hS9TxDTcgx4hB
 rZ4d2xsf4eCY8fU7DxiAJHz3E8vkRJzo1X32SkFipU/CxPAGe2OZSPxKvslaV859
 +JIdQ==
X-ME-Sender: <xms:qJePahrbqOxyXU1aejOI7rmYuFlCRlSCrqNCzyWU2TGI34wPo7JrJg>
 <xme:qJePahe01tnVO-ERilp3h5n3jWzV_SakWsf3ZudiMQS95w8acWjXWZQVCtXeAD_FX
 3K_XuT3-i0EhwiZuBw6Mbfxql0vN4i8zNUYX3SylWcilWI_U_NQo60>
X-ME-Received: <xmr:qJePaoqNrErIqnT_Wq0m3xMrUonUgznR69bnfG842ZEsmagjl2COZSI1u4DGYuksIsbiZKeKO0en>
X-ME-Proxy-Cause: dmFkZTGiTv4J4fX5Rq035h8NJPshsGtJQcLEjxUCXmHJqPzbDObAMSjkf2NR9I4837u8YI
 h2VEqaPaIpM9x3N4AK8l4pCrWcQ+ct9yNEm28XCxsBDqzSRo0XB4gvoUhGH/bXV7Wehg1m
 Ff2Ldi4HwxBRDUObE3N1cShzioVYXzU3UC68MUoWPhMdaaL0PGm5k64L9C7XqLIhDiMhBA
 VHxVwbtFx9XO+TFygEDJ7ecBYnN8Re9eKh3kaIMOa/OeHONxsKEYRvUGOVsSWHhjBoPt+V
 bmZcbhkhsq1zkPdCgapuaXurdqyfbWcUfKu0r44HBfBNQyxGwExYI1w1cY/4uJxeLVOnrw
 LA+nR1R5y0607W32r+7sxQg/BpoaDGtn+SU/6dD2G8qCDuFUFISbrm8+SoP+HLWZjmfPv8
 Lukk8W8eMDtR1ffMh+uuD8KqcZO6z4RG98HWasSjrKIdWVBVzwUWHR6Qs2qaa6PdFyrIAQ
 M3AT5P37AxVma2VV9diA1s1g/yI/44xOKu8sGH0fK9II7AMLd55m2HewUwS+Hz4egCaaHy
 pUtZ/Dw2jSttGlhL1HVLYyNvO9ZIkeCPRORrxiUOw70/Da/oaqHSWHQBFZIYoa6OT6wO5p
 RkqaCx2I8NO/deHmcj7D5dbfDY03YiT3CLz0IbZCztxV7aUN7/9kqEGvEHtQ
X-ME-Proxy: <xmx:qJePaqGNcEgIIwpCwODcuDXoukppVzmjxIYHiHYxIX46mc133kiDYQ>
 <xmx:qJePagsHgq2io_q2KHj6zyob-yYJ25USW_ZxPmvYSTxfPD0YvZMoSw>
 <xmx:qJePakXIAdaejEDB6xFh4W-3AGgQvQ37npuWmYeoLKTjEvLYSAdfgw>
 <xmx:qJePakHWXtGOO-pKkQTRAyw5NBHJNmEIXAqV0LrSfJ69eAVqu07GkA>
 <xmx:qJePakw2kErKpz6twnW5mWqr-LqZkGD-PmgJUHlo8i34unxdARfpJwQd>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Aug 2026 21:49:26 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: royalnet026@gmail.com
Cc: linux-rockchip@lists.infradead.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v9 05/13] dt-bindings: npu: rockchip: add rockchip,
 rk3576-rknn-core
Date: Thu, 27 Aug 2026 13:49:24 +1200
Message-ID: <20260827014924.254513-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAEWPSH7AcRb4uAnhmcL+kk3mQrgqYsQAYR=JQjJdkFGVK4qfHw@mail.gmail.com>
References: <CAEWPSH7AcRb4uAnhmcL+kk3mQrgqYsQAYR=JQjJdkFGVK4qfHw@mail.gmail.com>
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

Three things: the note you caught, the oc = 64 answer I have owed you since the
17th, and your SIZE_E question from the 20th. The last two turned out to have
the same source, and it was sitting on my disk the whole time.

First the note, because you were right and I was wrong about why. send-v9.sh
never passed --notes, so whatever was on the commit could not have reached the
mail. grep on the patch file I actually sent says

  $ grep -c '^Notes:' rfc-send-v9/v9-0005-*.patch
  0

so nothing was lost in a rebase and nothing needed recovering; the note is on
the commit and format-patch --notes emits it. The flag was missing, which is
exactly what you said. v10's send script regenerates with --notes and then
refuses to send unless the number of patches carrying a Notes block is exactly
one. Thank you for saying it before v10 rather than after.

Now oc = 64, concretely, as you asked: SIZE_E_2 = 1.

The expression, which is what the merge request emits and what I should have
sent instead of the sentence about 0x124 and 0x024:

  (DIV_ROUND_UP(oc, FEATURE_ATOMIC_SIZE) & 1) == 0 ? 0x80011111 : 0x80011011

At oc = 64 that is DIV_ROUND_UP(64, 16) = 4, even, so 0x80011111, so
SIZE_E_2 = 1. Your reading of the merge request line was right in every detail.
The sentence was mine and it named the arms by the wrong predicate, so discard
it and take the expression. You are also right that we should name the arms by
value and by count, so from here: oc = 64, 0x80011111, SIZE_E_2 = 1.

I did not have to derive that. geom/g_oc64.rknn, compiled at ic 16, 80x80,
k = 5, stride 2, oc = 64, has DPU 0x4050 = 0x80011111, and so do six more at
oc = 64. Two others, pp_oc64 at k = 3 stride 1 and pw48x64w56 at ic 48, 56x56,
k = 1, read 0x80021111, which differs only in RESERVED_0 (see below) and has
SIZE_E_2 = 1 as well. Nine vendor models at oc = 64 on this disk, all
SIZE_E_2 = 1, across three kernel sizes, both strides, and spatial sizes from
1x1 to 112x112.

Which brings me to your question from the 20th, whether different output
channel counts would exercise different SIZE_E fields, and whether two shapes
can rule out one that leans on SIZE_E_1.

I have 94 compiled vendor .rknn on disk from earlier rounds: oc 4 to 1024, ic 3
to 1024, 1x1 to 224x224, k = 1, 3 and 5, stride 1 and 2, regular and depthwise.
Reading DPU 0x4050 out of every one of them and decoding it against
registers.xml:

  SIZE_E_0   4     in all 94, it never moves
  SIZE_E_1   0     in all 81 regular models
             1     in all 13 depthwise models
  SIZE_E_2   0..1  regular, 0..3 depthwise

So the answer is no, and for a sharper reason than "we have not seen it move".
SIZE_E_1's axis is the depthwise flag, not the channel count. No output channel
count can be the shape that leans on it, because oc does not select it at all.
What does is regular against depthwise, and the driver already emits a
different word entirely on the depthwise path, whose SIZE_E_1 is 1, which is
the vendor's depthwise value on all thirteen.

That also means my comment in the driver was weaker than the truth. "SIZE_E_1
left at 0 because two shapes is not every shape" was honest, but 0 is what the
vendor emits on all 81 regular models, and upstream's 1 is what it emits on
depthwise. It is not an unexplained traced constant, and I have corrected the
comment to say so.

Your padding reading holds too, taken literally and with the depthwise padding
you pointed at. Depthwise pads to 64 output channels, so the last bank holds
one to four atoms of 16:

  oc            16  32  48  64  80  96  112  128  256  1024
  last bank     16  32  48  64  16  32   48   64   64    64
  atoms in it    1   2   3   4   1   2    3    4    4     4
  predicted      0   1   2   3   0   1    2    3    3     3
  observed       0   1   2   3   0   1    2    3    3     3

13 of 13 depthwise models, ten distinct counts, no exceptions, including the
three the driver's comment says it predicted rather than fitted: 16, 80 and
112. I had been carrying that as (atoms - 1) & 3, which gets the same numbers
and says nothing. Your form is the reason for them.

And while I had all 94 open I scored both candidate readings against the 81
regular models:

  parity, DIV_ROUND_UP(oc,16) even    0 wrong of 81
  modulo, oc % 32 == 0                1 wrong of 81

The one point where they disagree in that corpus is ocp56, oc = 56, ic = 64,
56x56, k = 1, stride 1, and the vendor emits 0x80021111, SIZE_E_2 = 1, which is
the parity answer. Every other model has an oc where the two forms agree, which
is why the original ten point sweep could not choose between them.

That is oc = 56 again. The board picked out a different model at the same
count, pw64x56w56, as the one shape that times out under the modulo form. The
board and the vendor's own compiler arrive at the same discriminating count
from two directions, which is better evidence than either alone and better than
I claimed at the time.

One thing I cannot explain, flagged rather than claimed. RESERVED_0 is 34 in
most of the regular models and 66 in a subset of them: 0x80011111 against
0x80021111, which inside the field is its bit 5 against its bit 6, both over a
constant 2. It does not correlate with oc, ic, spatial size, kernel size or
stride. Both values appear at oc 16, 64 and 128, at k = 1, 3 and 5, and at both
strides. What it does track is which batch of models it came from, which makes
a toolkit setting more likely than a geometry, but I have not established that.
The driver emits 34 always and the board is correct with it, so this is an open
thread rather than a defect I know about. Say the word and I will send you the
table.

v10 goes out shortly, and I said I would tell you here when it does. It is v9
plus six tags and the note, with no code change: I diffed every patch body
against its v9 counterpart and twelve of thirteen are byte identical, the
thirteenth differing only by the Notes block. Your two tags are on the patches
you sent them for, with the comments as you re-sent them on one line, so 02/13
carries "differential base" and 03/13 does not.

And thank you for the differential arm. The run that signalled success with an
output buffer that was never written, all 48 channels 0x80 and nothing in the
log, is the clearest statement of what these two patches close that anyone has
produced, including me.

Regards,
Jiaxing
