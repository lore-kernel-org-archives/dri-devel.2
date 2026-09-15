Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EFD7C88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 07:05:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44A9910E205;
	Tue, 15 Sep 2026 07:05:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="QVbj+TnS";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2A6810E205
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 07:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1789455899; x=1790060699; i=deller@gmx.de;
 bh=oI87ZYp//Jds/bPjtsW/wo0dDKyMhHYPN2zL4Tu0Br8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=QVbj+TnSsHtDuNtpWdOHmMcXwO8ZZLQdpo4XmzG16PKKMuo/qDftnGXhNcYYSsB0
 vijA0zcUapagIFEZXKZaTj21bP7GZpxMLVEvWcKzYZe6sK8V/tgnrtjpxNETJg+Cr
 d/a/+b3ju4mkD9NdPpJjkM5n/SqB6YrZBqoPdB4IeM2shWb+CiI17TEdFNHwp5GvV
 AtKWL9JdUIFv0BMVxJ7t0Xglr3VFkA5ky45//Y5d9W8+W4C/5ebKkPScq9lBLwAKd
 4KqXTGUx989A37DNzvq4IO8VP1LVSpioEVH80qE3Zy2XXjJiJWcCWqahsGYwOYyAG
 bD0MWPjdKuaLIZe7SA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmlTC-1wPqg90a4U-00ostN; Tue, 15
 Sep 2026 09:04:59 +0200
Message-ID: <6e9c98f9-56b8-4e8f-9707-a567656741d8@gmx.de>
Date: Tue, 15 Sep 2026 09:04:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: nvidia: Release write-combining handle on probe
 failure
To: Myeonghun Pak <mhun512@gmail.com>, Antonino Daplas <adaplas@gmail.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260915005447.51995-1-mhun512@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260915005447.51995-1-mhun512@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vozMbD7ewiF29iR4NtcOTDkY84iX46snqVJffXc/XSRKfKAMYuW
 iIAMhyj+r9By00Earr5MOlRgBGT916uIXK46+6mcGG2wv6/jOZg1vS4p2Ua5lsPw3tf8++Q
 XJEjubn09NgJcfsu4RiLUqi4vAKy7+jBu6hVQ0tAK3s7dfs0qdb3g0m1HlY1KeSe/vdxQMZ
 //is4SnaNReZWwa850jPA==
UI-OutboundReport: notjunk:1;M01:P0:WZEw98eEtTk=;MT374Tde9Y03HYdVFx6xyTu9tCq
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

On 9/15/26 02:54, Myeonghun Pak wrote:
> Failures in nvidia_set_fbinfo() or register_framebuffer() leave the hand=
le
> from arch_phys_wc_add() allocated. Release it in the shared error path,
> as nvidiafb_remove() already does on normal removal.
>=20
> The missing cleanup was already present in the initial Git import,
> when the driver used mtrr_add() directly.
>=20
> This issue was identified during our ongoing static-analysis research
> while reviewing kernel code.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>   drivers/video/fbdev/nvidia/nvidia.c | 1 +
>   1 file changed, 1 insertion(+)
Thanks for your patches!
I've added this one and the two similar ones regarding kyro and gxt4500
to the fbdev git tree.

Helge
