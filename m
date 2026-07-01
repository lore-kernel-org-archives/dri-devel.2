Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553BAC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:42:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A85E010EEC9;
	Wed,  1 Jul 2026 10:42:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Y6lGd+Ck";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBCDD10EEDF
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 10:42:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DC2C360138;
 Wed,  1 Jul 2026 10:42:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D171F000E9;
 Wed,  1 Jul 2026 10:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782902554;
 bh=sKqfrxc4220Hfr95SrWWNipq7HpfFkDKs4y4vFalt/A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Y6lGd+CkgGlmDQrwArOHaupSjPay1LqiSxqOztQTIiKAJRIm9qVinPnKohiVkV8VD
 YX1U3uDCfLj1cl5aWDe6pGTYU1TSyUP7+SVYrnPzMDKf1dpmRSvtpyys4gHlKgCE7E
 JiB+IUYgmvLGXrZI0v4nzrPVWD4v11PO9YGSRvGDBe0bLmQQ8sEFdF89gj/2k2hgG9
 QDmkWNeylmEY7+xm+CXpAbcykYA4eZCNUvwE8YeSzd70RJ5zzeF8rWHlBhZzhwzDxC
 ZbH5Z5dXMncA5EgUYGa9Yrt0clmDyjqgNTwbLecIPsfb0c2ckzSi84T2YFmrP60z0F
 s53kkmVylI8wQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/7] Add documentation for Sahara protocol
To: "Kishore Batta" <kishore.batta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260701-sahara_protocol_new_v2-v6-1-3a78362c4741@oss.qualcomm.com>
References: <20260701-sahara_protocol_new_v2-v6-0-3a78362c4741@oss.qualcomm.com>
 <20260701-sahara_protocol_new_v2-v6-1-3a78362c4741@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 10:42:34 +0000
Message-Id: <20260701104234.74D171F000E9@smtp.kernel.org>
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
- [Low] Multiple typographical errors, misspelled constant names, and a cop=
y-paste error exist in the newly added Sahara protocol documentation.
--

Note: The format of this report has been altered to provide a free-form sum=
mary of the findings rather than inline code quotes, due to strict content =
recitation restrictions.

commit ea565b1ec139594103ddde3b826aade3f2071329
Author: Kishore Batta <kishore.batta@oss.qualcomm.com>

Add documentation for Sahara protocol

This commit introduces documentation for the Qualcomm Sahara protocol. It d=
etails operational modes such as image transfer, memory debug, and command =
mode, explaining their functions and respective packet flows.

[Severity: Low]
This isn't a bug, but there is a typo in the mode constant name defined aro=
und line 206 in Documentation/mhi/sahara_protocol.rst. It is written as SAH=
ARA_MODE_MEMORY_DBEUG instead of SAHARA_MODE_MEMORY_DEBUG. Could this typo =
mislead developers who are referencing the protocol definitions in their co=
de?

[Severity: Low]
In the "Packet flow for memory debug" section around line 814, the text int=
roduces the sequence with "The packet flow sequence for image transfer is a=
s follows:". Is this a copy-paste error from the previous section? Should i=
t refer to "memory debug" instead of "image transfer" here?

[Severity: Low]
There are several typographical errors scattered throughout the new documen=
tation file that might be worth correcting for overall clarity and professi=
onalism. These include:

- "sate" instead of "state" (e.g., in "Reset Sahara sate machine packet")
- "Sahar" instead of "Sahara" (e.g., "The Sahar client interprets")
- "pcket" instead of "packet" (e.g., "content from the data pcket is writte=
n")
- "targert" instead of "target" (e.g., "transferring the image header to th=
e targert")
- "successgul" instead of "successful" (e.g., "receives a successgul end of=
 image")
- "firgure" instead of "figure" (e.g., "The below firgure shows")

Would it be possible to fix these minor typos in a subsequent revision?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-sahara_pro=
tocol_new_v2-v6-0-3a78362c4741@oss.qualcomm.com?part=3D1
