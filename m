Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 227B9C54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 09:12:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5115310E1E3;
	Fri, 31 Jul 2026 09:12:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="JROYLHPP";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E59D10E1E3
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 09:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1785489120; x=1786093920; i=deller@gmx.de;
 bh=8b6rQ0gHE1U5xaCm71Grk1kI8r1zVIBSkyjdnJhmJ4A=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=JROYLHPPxOV97DOF8peydfPebnqv2+aroMLg+6PWwLUyjuyQq4hFek2HJwgBNvJO
 7UjOLYyovETnZ3VjGs/HtzuTBKwMI3PytitL8s4oblexob+H7WAelseUTKZO6sH0X
 QKRRCsakFxq+owzQzeL2s7chea+GbFPGHKJoF2xBMede1nh0i4E4Z0rgG56NFYYZH
 XgxrTAfK8hOClZ++I0sKPJPRtAMyEfPeAhD5dLKk/Ch8tPUs5yI5hvFnA7/zKbpad
 +nbI2fUOgyxe7zaiYmuaM8mHX5voJ2oe9nbZpbWRFJfNkQOMVfMAr3MXQQZtYO6kK
 VpejBwOYxbdSJCXDpw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIx3C-1wWPyf48Lq-00HhcM; Fri, 31
 Jul 2026 11:12:00 +0200
Message-ID: <e21366e9-6ca6-4607-a54b-cf30ce6e5d1f@gmx.de>
Date: Fri, 31 Jul 2026 11:11:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] fbdev: tdfxfb: Make "unbooted" cards work
To: Daniel Palmer <daniel@0x0f.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260730182640.2808572-1-daniel@0x0f.com>
 <6bbf7e18-92b9-4d18-beb0-0c9812fc7ba8@gmx.de>
 <CAFr9PX=JX_s+J+5twareTYC_U6SRGazXo0XDP6e4r2R4f+q3CA@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAFr9PX=JX_s+J+5twareTYC_U6SRGazXo0XDP6e4r2R4f+q3CA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ujq1l5fCV9+uvdhkbyFgTJy7D7fOGoKfEZce2Sv3iAnbkA3gMmH
 71FX2pAwA/ZfQU5rstYnk5445WjZBITmrzA8oMTlMFgFm21+MVSiUyC6tQnP6sYoa2tYAVI
 q4rcsnXN/ZNJuTcZw3fjoZiMcaL0NrhS9zI+Ogsj3rEfgSU5OPvTpOqzYP935UNLmhTR29/
 a2ArPzAS6Ig0eUcJRHK4w==
UI-OutboundReport: notjunk:1;M01:P0:bhS6i48diCM=;UjrcVL4GLXUJFDpCNVWHL6WvgBf
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

Hi Daniel,

On 7/31/26 10:48, Daniel Palmer wrote:
> On Fri, 31 Jul 2026 at 16:25, Helge Deller <deller@gmx.de> wrote:
>> Nice work!
>>
>> Series applied to fbdev git tree.
>>
>> Thanks for doing this!
>> Helge
>=20
> Sashiko flagged up some things that are valid. Should I send a v2 or sen=
d fixes?
I prefer a clean-up v2 version.
Dropping and replacing patches is easy for me as long as they are in the f=
or-next branch.

Helge
