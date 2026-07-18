Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A363C4450A
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 19:39:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EA9E10E5F5;
	Sat, 18 Jul 2026 19:39:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="auN3lntt";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6664810E5F5
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 19:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1784403566; x=1785008366; i=deller@gmx.de;
 bh=yBzTB/Hv9POxqvF0HU/7TUrVaj+BrAMU6Oq/0aE3f8U=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=auN3lnttLSom0jkxGIbDmX/MtO3eaJ00B10zd0i0PwdlV+WObZ4T2RtH3abInREH
 gA/o+vX+6M7dvGe+DlEIJZlErOhXypLTYzCFqfJ9MNelTMVsk5nzX/7hz67t0TWDf
 aO7UdN88zY/bwq3MbHGTkz0OB0B0zgup/8JakFjEKHr10y38tH3/yP65JDbobuxE6
 HNS+hSUrxMYKxbobwdeqzNzj6gUkbr0Sa+hz39e1NgBpuY2T3NZrYZRqg+VbnasS3
 DboQfEDp5rr9KskZif0GKRmO35CLD9ZgvcT4I9koVIndlWnjsXBddqOWI+4dcCxVU
 oJ1JAIGusY4NG9AiuQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1ML9yc-1wSxEy2fVi-00Nix2; Sat, 18
 Jul 2026 21:39:26 +0200
Message-ID: <87e98cba-247d-41d9-9d67-e00b69e91c39@gmx.de>
Date: Sat, 18 Jul 2026 21:39:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fonts: fixup font.h kernel-doc warnings
To: Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>, linux-fbdev@vger.kernel.org
References: <20260718191326.1907423-1-rdunlap@infradead.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260718191326.1907423-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nfh0HH5Bwiu8n/nls3OR+r8e29ju1Xr8LgSrI2xqmakXDiE5MHU
 qwO8t1dz4tfy152KzLwovhzy0kUJ6Dz5oIDJ7rhs4LHWYUgwMsIIjbGIWAWjPg8lnvw2iUm
 zeydCJi7AIl4WSe14AAFdqoXGaXSh+Tx3UdvEUfJJxjOZA8dJWn3Gmw86r3YWtKhQihPhbM
 sB65gVFI0KPf0HoHGTziQ==
UI-OutboundReport: notjunk:1;M01:P0:JULGCjfLKxQ=;hOjTGahiV3sJE26l+00SVN/v4b8
 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
 =
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

On 7/18/26 21:13, Randy Dunlap wrote:
> Use the typedef keyword when describing a typedef.
> Add the missing function return value for font_glyph_size().
>=20
> Warning: include/linux/font.h:84 cannot understand function prototype:
>    'typedef const unsigned char font_data_t;'
> Warning: include/linux/font.h:53 No description found for return value
>    of 'font_glyph_size'
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Helge Deller <deller@gmx.de>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: linux-fbdev@vger.kernel.org
>=20
>   include/linux/font.h |    4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
applied to fb-dev git tree.

Thanks for fixing, Randy!

Helge
