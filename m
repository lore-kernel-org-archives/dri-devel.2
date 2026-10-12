Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33CF2CA9EDE
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 18:24:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5125810E3D9;
	Mon, 12 Oct 2026 18:24:24 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE05A10E3D9
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 18:24:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A6550403F4;
 Mon, 12 Oct 2026 18:24:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF421F008A1;
 Mon, 12 Oct 2026 18:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791829457;
 bh=ozBZ57+wJ3J+fy5V10QHkPPfqZLfX/rFUOc0TdpIoeA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BLtPgqEPp0kX+pduRTvII8CRHsdtP6IFVl7MQiVOLCA11iGRGWmiM7Mj1HRJ6VBbR
 dIlJ3I1ReJG/xHzxnrEm436r4z9VwBIJH9ncvIQGaVbdHwQhHkcQrYC1vRN4jeTxxq
 tBEor/26EEe1r8b3dqCwLnVIiQ+CfRkeZYgNb1GihN44Ed0Ky9Xy+BGzIBzAyvW/UI
 jBmhKzZMRorgUadcqHbiANDTAAcmu3Hv8uM0wzuPo58f2wD4LE2UwxhTvjth3HCNw/
 tSYXGSrpNrjKR5scuvg9Hmsjai5u9qwNF2wg9Sn38AhUj3F5ZaRdIidTLDaP8PuziT
 lS62reennzDMQ==
Message-ID: <sashiko-outbox-168536@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/7] Add documentation for Sahara protocol
To: "Kishore Batta" <kishore.batta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261012-sahara_protocol_new_v2-v8-1-e12939d229a1@oss.qualcomm.com>
References: <20261012-sahara_protocol_new_v2-v8-0-e12939d229a1@oss.qualcomm.com>
 <20261012-sahara_protocol_new_v2-v8-1-e12939d229a1@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 18:24:17 +0000
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
- [Low] docs: typos, copy-paste errors, and ReST formatting issues in sahar=
a_protocol.rst
--

Describe the issue without repeating the exact code. Place the [Severity: <=
level>] tag before each description.

I repeat: DO NOT QUOTE DIFFS using '>' or any block-quoting format. You may=
 use tiny inline snippets if absolutely necessary, but no large blocks of c=
ode. Do not include diff headers (`diff --git`, `index`, `---`, `+++`, `@@`=
).

Generate the review report directly.commit ab93a6140a5ba3ed32ff6b359193e1a5=
caa55f4c
Author: Kishore Batta <kishore.batta@oss.qualcomm.com>

Add documentation for Sahara protocol

This commit introduces new documentation for the Sahara protocol, covering
its operational modes, image transfer, memory debug, and command modes used
for operations like retrieving DDR training data.

[Severity: Low]
In Documentation/mhi/sahara_protocol.rst under the Command packet optional
fields table, there is a typo for the Reset Sahara state machine packet. The
field mentions 'sate machine' instead of 'state machine'.

[Severity: Low]
In Documentation/mhi/sahara_protocol.rst under the Hello Packet mode table,
there is a typo in the constant name for memory debug mode. It is written as
SAHARA_MODE_MEMORY_DBEUG but should probably be SAHARA_MODE_MEMORY_DEBUG.

[Severity: Low]
In Documentation/mhi/sahara_protocol.rst, also within the Hello Packet mode
table description for SAHARA_MODE_COMMAND, there is a typo. It mentions 'The
Sahar client interprets' instead of 'Sahara'.

[Severity: Low]
In Documentation/mhi/sahara_protocol.rst under the Hello response packet
section, the numbered list explaining the response contents immediately
follows the preceding sentence without a blank line. In ReST formatting,
this missing blank line causes the numbered list items to be squashed into a
single continuous paragraph when rendered.

[Severity: Low]
In Documentation/mhi/sahara_protocol.rst under the Write data packet
section, there are two typos in the same sentence. It says 'data pcket is
written to the output file, The format...'. 'pcket' should be 'packet', and
there is a comma splice where a period should be used before 'The'.

[Severity: Low]
In Documentation/mhi/sahara_protocol.rst under the Packet flow for Image
transfer section (step 6), there is a typo where 'targert' is used instead
of 'target'.

[Severity: Low]
In Documentation/mhi/sahara_protocol.rst under the Packet flow for Image
transfer section (step 8), there is a typo where it says 'successgul'
instead of 'successful'.

[Severity: Low]
In Documentation/mhi/sahara_protocol.rst under the Packet flow for memory
debug section, immediately following the packet diagram, the text says 'The
packet flow sequence for image transfer is as follows:'. This appears to be
a copy-paste error from the previous section and should likely say 'for
memory debug'.

[Severity: Low]
In Documentation/mhi/sahara_protocol.rst under the Subsequent boot scenario
section, there is a typo in the introductory sentence. It says 'The below
firgure' instead of 'figure'.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-sahara_pro=
tocol_new_v2-v8-0-e12939d229a1@oss.qualcomm.com?part=3D1
