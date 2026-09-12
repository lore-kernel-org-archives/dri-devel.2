Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA7FC88E56
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 16:22:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7D1210E6C0;
	Sat, 12 Sep 2026 16:22:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="YeqYBi5G";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A882710E6C0
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 16:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1789230151; x=1789834951; i=deller@gmx.de;
 bh=0hMQ7wfCFX3xALD+C6UvdgNeTsaw/ak1SWAOl3b+2LI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=YeqYBi5GzRk/NPS+iur5A3YqypXSwDchjY+WJgmWozXXF+Ov9cr3acnYSyDtAksH
 Zb3W1fbGvGXkLEVMWFswJ0SctZPg8f5HWxOPp1hl6yTiwP3rSz41zoF40jbUNsdiI
 ScLqdOrgHTabVxpck6E+cWErnPTQ6rKhvkkreCPROgSCQoPZk4ln72gl7Yic2CZ61
 8ooc71AWlVgUoMl1faRKG9RA6KsKWbd1XNL91wx+YrXql5StFeqEqpG0ntyprEXhd
 Q9dFBfXiRpAZOvQSKzNaLQESG8/95AHhI9N1L0QtYU3jSGoIewCCJaDJlnRP0aGrp
 a4vzRpf2zZ+6eKYnMw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MwQXN-1wmWCQ32ij-00y4RX; Sat, 12
 Sep 2026 18:22:31 +0200
Message-ID: <e93f4477-08f7-4261-b296-e0cba604bcec@gmx.de>
Date: Sat, 12 Sep 2026 18:22:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: fix typos in comments
To: Hemanth Selam <hemanth.selam@gmail.com>,
 Kristoffer Ericson <kristoffer.ericson@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20260904122250.29879-1-hemanth.selam@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260904122250.29879-1-hemanth.selam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OxH2jpMylQDFPGd2GNHRpYSe1dwQwHNoZ48lypSQz/6TtTSmMNo
 MsAVdl9nSLZqd+TK242UzbebIc8d54o54huSauRxeuiNYem4+6qtZKZxya3OvDVG2j4THL8
 sroW83jlBg+fF4ecKigHv8EOYPKQdCqR+5aRthfiw+6gPX/2HLnZZE0a3Fm4v20ZJU8bt4A
 M9xVyce+kZlgi+vqyg1RA==
UI-OutboundReport: notjunk:1;M01:P0:AXr3D0sJiwg=;xhozoBiqj9raCtkoaSXxLipODe/
 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
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

On 9/4/26 14:22, Hemanth Selam wrote:
> Fix typos in comments, reported by scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt.  Only touches comments, no cod=
e
> changes.
>=20
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> ---
>   drivers/video/fbdev/s1d13xxxfb.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
applied.

Thanks!
Helge
