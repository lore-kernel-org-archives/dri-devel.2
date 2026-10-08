Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D7CACA6007
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 06:28:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6F6310E771;
	Thu,  8 Oct 2026 06:28:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FkafSfEz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D255D10E771
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 06:28:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D659F601DB;
 Thu,  8 Oct 2026 06:28:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645331F000FF;
 Thu,  8 Oct 2026 06:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791440889;
 bh=6jPCzsMeI/wydx89WBVlp4FAivgi642SbGG7G/RUGJY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FkafSfEz+9fWLBvFgWp/nGz0HS7Gls+2spU2MiseFyLtTNRkEz/Q6Jvy0zb9ly69b
 PXOmnj7+s0ktY8PxRl9SAodcGo0aHa+vbL+eVpGylw1MzklCTojLD0Tu9eMOOEoqn8
 dosMRUQvmrx8D4YMeedPYdk3rPKUlg/kTeqIW+gjEhINvLV7e6vjGxvOyyLncruq7j
 B15qeD0HOaEVUhQuLCDUAJvFhLzwaKqBf0SbnasM0OfwPdVKqjD0vKAn3LdeQnmSIi
 /2pBgMK4tpl8LbsshhgqUcvII6vRId4Rquefj/gpP+w8d1tHvx+j2OZuSWL9Bkshe1
 ytQ9YjdWvAi1g==
Message-ID: <sashiko-outbox-163692@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/7] Add documentation for Sahara protocol
To: "Kishore Batta" <kishore.batta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261008-sahara_protocol_new_v2-v7-1-90d278bd7414@oss.qualcomm.com>
References: <20261008-sahara_protocol_new_v2-v7-0-90d278bd7414@oss.qualcomm.com>
 <20261008-sahara_protocol_new_v2-v7-1-90d278bd7414@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 06:28:08 +0000
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
- [Low] docs: mhi: multiple typos and minor copy-paste errors in Sahara pro=
tocol documentation
--

commit 6e5d4c22229dc0e189e8ab259dab37fed17658dd
Author: Kishore Batta <kishore.batta@oss.qualcomm.com>

    Add documentation for Sahara protocol
   =20
    Introduce documentation for the Sahara protocol, describing its
    operational modes and their respective functions.

> diff --git a/Documentation/mhi/sahara_protocol.rst b/Documentation/mhi/sa=
hara_protocol.rst
> new file mode 100644
> index 0000000000000..3190e3e5a2820
> --- /dev/null
> +++ b/Documentation/mhi/sahara_protocol.rst

[ ... ]

> +|   0x12  | 64 bit Read   |  Target | Reads specified number of bytes fr=
om    |
> +|         | data          |         | host for a given 64 bit image.    =
      |
> ++---------+---------------+---------+-----------------------------------=
------+
> +|   0x13  | Reset Sahara  |  Host   | Resets Sahara state machine and en=
ters  |
> +|         | sate machine  |         | Sahara entry without target reset =
      |
> +|         | packet        |         |                                   =
      |

[Severity: Low]
This isn't a bug, but there's a typo here: 'sate machine' instead of
'state machine'.

[ ... ]

> ++-----------------------------+---------+-------------------------------=
-----+
> +|SAHARA_MODE_IMAGE_TX_COMPLETE|  0x1    | Image transfer is in the compl=
ete  |
> +|                             |         | mode. Transfer image from the =
host.|
> +|                             |         | After completion, the host sho=
uld  |
> +|                             |         | not expect another image trans=
fer  |
> +|                             |         | request.                      =
     |
> ++-----------------------------+---------+-------------------------------=
-----+
> +|  SAHARA_MODE_MEMORY_DBEUG   |  0x2    | Memory debug mode. The host sh=
ould |
> +|                             |         | prepare to receive a memory du=
mp   |
> +|                             |         | from the target.              =
     |

[Severity: Low]
This isn't a bug, but there's a typo here: 'DBEUG' instead of 'DEBUG'.

[ ... ]

> ++-----------------------------+---------+-------------------------------=
-----+
> +|    SAHARA_MODE_COMMAND      |  0x3    | Command mode. The host execute=
s    |
> +|                             |         | operations on the target by se=
nding|
> +|                             |         | the appropriate client command=
 to  |
> +|                             |         | the Sahara client running on t=
he   |
> +|                             |         | target. The Sahar client inter=
prets|
> +|                             |         | the client command and the res=
ponse|

[Severity: Low]
This isn't a bug, but there's a typo here: 'Sahar client' instead of
'Sahara client'.

[ ... ]

> +To initiate a write data transfer, the target fills the write data packe=
t with
> +the image ID corresponding to the image data that it wants to send. The =
target
> +also sends the offset into the output file and the length of the data(in=
 bytes)
> +it wants to write from the target. As soon as the host receives the pack=
et, the
> +host opens an output file and waits to receive the data packets. After t=
he
> +packet is received, the content from the data pcket is written to the ou=
tput
> +file, The format of the write data packet is as follows:

[Severity: Low]
This isn't a bug, but there's a typo here: 'pcket' instead of 'packet'.

[ ... ]

> +5. After receiving a read data request, the host parses the image ID, da=
ta
> +   offset, and data length to transfer data from the corresponding image=
 file.
> +   The host sends the requested data without any packet header.
> +
> +6. The target directly transfers the data to the destination address wit=
hout
> +   any software processing or temporarily buffering of the data in system
> +   memory by transferring the image header to the targert and setting the
> +   receive buffer for the data as the destination address in system memo=
ry.

[Severity: Low]
This isn't a bug, but there's a typo here: 'targert' instead of 'target'.

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

[Severity: Low]
Should region 2 request 'size of region 2' here instead of 'size of region =
0'?

[ ... ]

> +Subsequent boot scenario with valid DDR calibration data
> +--------------------------------------------------------
> +
> +The below firgure shows the subsequent boot scenario with valid DDR cali=
bration
> +data process being loaded from host to target.

[Severity: Low]
This isn't a bug, but there's a typo here: 'firgure' instead of 'figure'.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-sahara_pro=
tocol_new_v2-v7-0-90d278bd7414@oss.qualcomm.com?part=3D1
