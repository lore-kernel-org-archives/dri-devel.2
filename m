Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F74CD98CC
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 10:52:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8D6010EE6E;
	Thu, 11 Jun 2026 10:52:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="A0ncp/5p";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C0E210EE6E
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 10:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1781175151; x=1781779951; i=deller@gmx.de;
 bh=9Um/zqKC+C47HLwVQbQuv7j3eXhu89b1jL/Iv/VQW4w=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=A0ncp/5ppJa01CUmxPtBBIANHUt03aSsfTRLBCggn01EiAlNQSyh8iu+A/TKVjqM
 h/y2zz9QnwwkhHWz/j0eWdl1nibQvpBFkgJYozM2mV5/OEb+HBXAoyUbvoZaKb3bM
 bilMzLI0Ev+2e4fOm4IY1hJqkhaLJu82bjUqaXU1i5rCDFXdg23k8uos+eCqq0Wco
 Q2Lc8F7WOis9gyJKWJkzEsJRNhK5AnMH2bXSzjTmlOEmCzSsJoN+tYwZ/tSBi0Q0d
 BMZcqn6Q+y8TvPUZTM9xUINWum84T5BdGdpeBhaPjIx59Or/f2SewLAZOhMFVq/WY
 5uWqd0pCXPCYCYsN4g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MV67o-1wh5BZ1D9C-00Tcia; Thu, 11
 Jun 2026 12:52:31 +0200
Message-ID: <e0047f95-987c-4be8-9e49-496dd4a317b8@gmx.de>
Date: Thu, 11 Jun 2026 12:52:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fbdev:modedb: fix a possible UAF in fb_find_mode()
To: Geert Uytterhoeven <geert@linux-m68k.org>, Tuo Li <islituo@gmail.com>
Cc: simona@ffwll.ch, tzimmermann@suse.de, kees@kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260610025014.5913-1-islituo@gmail.com>
 <CAMuHMdW_+WE2uUyqAEhSqT7F4pWseO6Gygbw3tCo7LpAJB2C4Q@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAMuHMdW_+WE2uUyqAEhSqT7F4pWseO6Gygbw3tCo7LpAJB2C4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:27TFdb3gvnteYpEB7y9S+Er194qZSizitphUpAvDdt7IswiRmuL
 ub27THILW6UYKXeUwAH2THjWNY5Q+r7vCVCXRIMqf4wmYWSdLh6cDdj8Vnt2lOOoGfahSS3
 855unAAsjKEgr670seHJnskK6qmV074UGTOBnVWEX8Mmdb6X9djsGt2qwvuEKrtg6NsEr5H
 BrnwhS0YMTefbyNkklRRw==
UI-OutboundReport: notjunk:1;M01:P0:uPUohvRJSDw=;TTeMEDiHKDBj2YGtW9EqewXXLry
 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
 r/XBqg==
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

On 6/11/26 10:10, Geert Uytterhoeven wrote:
> Hi Tuo, Helge,
>=20
> On Wed, 10 Jun 2026 at 04:50, Tuo Li <islituo@gmail.com> wrote:
>> If mode_option is NULL, it is assigned from mode_option_buf:
>>
>>    if (!mode_option) {
>>      fb_get_options(NULL, &mode_option_buf);
>>      mode_option =3D mode_option_buf;
>>    }
>>
>> Later, name is assigned from mode_option:
>>
>>    const char *name =3D mode_option;
>>
>> However, mode_option_buf is freed before name is no longer used:
>>
>>    kfree(mode_option_buf);
>>
>> while name is still accessed by:
>>
>>    if ((name_matches(db[i], name, namelen) ||
>>
>> Since name aliases mode_option_buf, this may result in a
>> use-after-free.
>>
>> Fix this by extending the lifetime of mode_option_buf until the end of =
the
>> function and using scope-based resource management for cleanup.
>>
>> Signed-off-by: Tuo Li <islituo@gmail.com>
>> ---
>> v2:
>> * Use scope-based resource management instead of manual kfree() calls.
>>    Thanks to Helge Deller for the helpful advice.
>=20
> Thanks for your patch, which is now commit 85b6256469cebdac ("fbdev:
> modedb: fix a possible UAF in fb_find_mode()") in fbdev/for-next, and ha=
s:
>=20
>      Cc: stable@vger.kernel.org # v6.5+
>=20
> I believe it needs:
> Fixes: 089d924d03d5c17b ("fbdev: Read video=3D option with
> fb_get_option() in modedb")
>=20
> and that commit entered v6.4-rc1, i.e. not v6.5?

Right, but I added the v6.5+ tag, because this patch uses the "__cleanup()=
 based infrastructure",
which I think was introduced with v6.5.

Helge
