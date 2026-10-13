Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA050CC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:52:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9B0510E757;
	Tue, 13 Oct 2026 08:52:00 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6526E10E757
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 08:51:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 87EE2600D1;
 Tue, 13 Oct 2026 08:51:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6E31F000FF;
 Tue, 13 Oct 2026 08:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791881513;
 bh=3K1S07bAxMkxV5MQEVFfAmY7mAXCq3TGYCNLMQbRnb4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UWXFDnVvvhPMFtQTZ4io+piR2g1THPMmSW8dqsBGUGW1SEwW5mv6WTLMyHNOAoTW3
 4uJbyUk1k5un9wqGgFnVANCyk2HAtHlB3Qh0h9xvFou+BbRR7bv8EL/KPxFZshbZdG
 2K9KQWkE2G/XNmoGfMiexowiwRTntEm13xXTVXn1dFq1pZYGml6p2ofvL/xmEZ2tfr
 Y2rL7B75MCx856TIyYWxuU4ZxwT4cCfLeJbwoNRsyIr9QLGrzDrIGFqHAUaTl9J3C2
 2c749uywt7OnNeq1aVSYoeix+2obm3T/COnu/saKpS2sv20kvhqgmSI44vXCGkni0x
 IafS4Ipybrz8Q==
Message-ID: <sashiko-outbox-169280@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/7] Add documentation for Sahara protocol
To: "Kishore Batta" <kishore.batta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261013-sahara_protocol_new_v2-v9-1-dc9f24357c4a@oss.qualcomm.com>
References: <20261013-sahara_protocol_new_v2-v9-0-dc9f24357c4a@oss.qualcomm.com>
 <20261013-sahara_protocol_new_v2-v9-1-dc9f24357c4a@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 08:51:52 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] doc: typographical errors in Sahara protocol documentation
--

commit 8d07d5d5d03da68e6f60aacfd0b9952197576e1b
Author: Kishore Batta <kishore.batta@oss.qualcomm.com>

Add documentation for Sahara protocol

Introduce documentation for the Sahara protocol, describing its
operational modes and their respective functions. The image transfer mode
enables firmware transfer from host to device. The memory debug mode
allows extraction of device memory contents to host.

> diff --git a/Documentation/mhi/sahara_protocol.rst b/Documentation/mhi/sa=
hara_protocol.rst
> new file mode 100644
> index 0000000000000..3190e3e5a2820
> --- /dev/null
> +++ b/Documentation/mhi/sahara_protocol.rst

[ ... ]

> +|   0x13  | Reset Sahara  |  Host   | Resets Sahara state machine and en=
ters  |
> +|         | sate machine  |         | Sahara entry without target reset =
      |
> +|         | packet        |         |                                   =
      |

[Severity: Low]
Does this code contain a typo? It looks like "sate machine" should be
"state machine".

[ ... ]

> ++-----------------------------+---------+-------------------------------=
-----+
> +|  SAHARA_MODE_MEMORY_DBEUG   |  0x2    | Memory debug mode. The host sh=
ould |
> +|                             |         | prepare to receive a memory du=
mp   |

[Severity: Low]
Does this code contain a typo? It looks like "SAHARA_MODE_MEMORY_DBEUG" sho=
uld
be "SAHARA_MODE_MEMORY_DEBUG".

[ ... ]

> +host opens an output file and waits to receive the data packets. After t=
he
> +packet is received, the content from the data pcket is written to the ou=
tput
> +file, The format of the write data packet is as follows:

[Severity: Low]
Does this code contain typos? It looks like "pcket" should be "packet", and
the comma after "output file" should be a period.

[ ... ]

> +6. The target directly transfers the data to the destination address wit=
hout
> +   any software processing or temporarily buffering of the data in system
> +   memory by transferring the image header to the targert and setting the
> +   receive buffer for the data as the destination address in system memo=
ry.

[Severity: Low]
Does this code contain a typo? It looks like "targert" should be "target".

[ ... ]

> +8. The host sends a done packet to allow the target to exit the protocol=
 after
> +   it receives a successgul end of image transfer packet.

[Severity: Low]
Does this code contain a typo? It looks like "successgul" should be
"successful".

[ ... ]

> +                          |         MEMORY_READ       |
> +                          |   (Address from region 1 ,|
> +                          |    size of region 1)      |
> +                          |-------------------------->|
> +                          |         RAW_DATA          |
> +                          |     (size of region 1)    |
> +                          |<--------------------------|
> +                          |         MEMORY_READ       |
> +                          |   (Address from region 2 ,|
> +                          |    size of region 0)      |
> +                          |-------------------------->|
> +                          |         RAW_DATA          |
> +                          |     (size of region 2)    |
> +                          |<--------------------------|

[Severity: Low]
Does this diagram contain a copy-paste error? For region 2, the memory read
packet requests "size of region 0" instead of "size of region 2".

[ ... ]

> +Subsequent boot scenario with valid DDR calibration data
> +--------------------------------------------------------
> +
> +The below firgure shows the subsequent boot scenario with valid DDR cali=
bration
> +data process being loaded from host to target.

[Severity: Low]
Does this code contain a typo? It looks like "firgure" should be "figure".

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-sahara_pro=
tocol_new_v2-v9-0-dc9f24357c4a@oss.qualcomm.com?part=3D1
