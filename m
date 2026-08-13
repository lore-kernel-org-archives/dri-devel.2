Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3022C5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 10:30:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EF5C10E0AE;
	Thu, 13 Aug 2026 10:30:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=fooishbar.org header.i=@fooishbar.org header.b="dgphkjyc";
	dkim-atps=neutral
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B71910E4A2
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 10:30:06 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-84faf0fa17eso609020b3a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 03:30:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786617006; cv=none;
 d=google.com; s=arc-20260327;
 b=F0JRZrzjiyxBDoVC+TGud7LOuO4kfsZYW+29NBSzye9rpZEXArUSqA6NMVRsByKVPi
 aNDDmqe2khslqdj7ogNK5XXgj0d0wNLCJFavmxxTBzz1g3hQ4U7eTrkrkHyT6o7+1ap+
 iG9Akci1SQ8X9h/GZbewxKPdRfl8ely6YNwAguu99hDlziY+4vkkGohRrKgn6+wfvPZ/
 yWYagchKUaI0aeoNWleyHTS/i0ekxnvf57u2TsnAqMmizkZeNyMYMQmBCb/jH+j18uv9
 +sMGGmySMtNPBfURM+rrlyhyUwEvZrAOASWDS9uRzXcL64EswVclmM6Q+cnMh1qA7ZlY
 BPGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WXpJ0s2z/yoiEHWuJMF9fdHN283vjFazEZaxaUcCo5I=;
 fh=At54s/wXlwyJr9GgDHwl0wDRaZRKOzg+tPHJX5+YYcQ=;
 b=p0oi1sz9BD1VthOY4kNb2NpHlwLxDuEGCVoACGhpAfhgxPxQN6W6ZKeoRfX+K/GaZT
 LdRCiPo+oImpXyBJf+TxSpVSTwnoEc1hamBGpsUrjKGTfs/RkKV518s3MSjBkgpDLTP2
 yMOP6rp3lfUOFaR9r+d2YG6KAPl0N9DoKi8dNKdXCOT/Kqm35iwmaqiN8xl6LoYYu7Ru
 xIun4afOfE1PhnJlXU8vJ1RQioOPctEJxUrXqYBmzib7VAyDUpkSRQz0VYUg4agx/eQJ
 eBXz2h7zI+GPw6qlRPXEg27XepeBONPrxU05mIqlIc1DfQDOo4KWNu18GvivTWeeqTJn
 D0Ew==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1786617006; x=1787221806;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WXpJ0s2z/yoiEHWuJMF9fdHN283vjFazEZaxaUcCo5I=;
 b=dgphkjycg+cWzvWGiKjA/09JEi/G9rC3c5xINrgiunpMtCkEbW4rbsmAtFqt2x00xa
 l8KTDkHC7WJUpUg28dEnUpsKywUNDdQ6xyNp9s/OADHvCktukFoW7V0h1sHMbMNt7kdt
 LJXYgY8MZ1CGVi/TY+cEUlFKDLJmUqYeZtEKXkRZOSfwMo+hfEAVu6i03mLTZTX+cMnf
 j6CSvPMbg/jfi1wfdInvKLUhVyWIeLGc5NPRfvwwqILSowZiWtOaGuEYGDoc1LIcRTRi
 My2tM73XkT4vU0DgYljhsaDeQywVmDkDKQqC/jo31t1aWGlwanN7gSx4IJFQombKVAAC
 VbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786617006; x=1787221806;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WXpJ0s2z/yoiEHWuJMF9fdHN283vjFazEZaxaUcCo5I=;
 b=ICcHlekMov/MD/iJvqHZKIREs+zQuAPv7uY4aRgQaTXkvYxdDjx2p1pOdWmj2GC97x
 D8ncqX1Rkgo6DlKIiEB1ra85GWNFtVp7UbZ1mOLGdB3eAMklGnhCcD+C8dyIV0Yy7LRh
 pQlxSPdUJUSqtlO0v01/NK2WcDmA7Hv/mXhcpYeAEtMYerWRjsK2heg2XrQA6LNRHeZy
 qRZ1F3Rl5M3Caerl+tlwZWiqwZj4WsgoposfdqivkqHYKgxDjaWFb2DoUCQWPLjWKylT
 lxdEeyEDQezVJiEFrlCA6ZS5h/VbI2RKn4UFKQstqU8BN/T/RsbFd/PySWVoLIPfbrYo
 cn2g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrpcNynBegOBQx1/5Htg+DfIACV+y2h9CeaQ6jBAe19KzFEwENrZG0vyQY2EY51f7Q0JSDnvIiko7I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwJq92wg8bgAzRThYfCgOGirI4m73fGy25q4OjZxaqHWo3FGg27
 pPzwv4I5ZTXcj4MNsf/yb+8swBT8Gev/zT3VZwyeF9OqUSJhJt6g1y7XRFupBly5ULgDAwt82Pn
 bP2i0owkz6+C+cjK8KXeahZ/+JM6pBj2kZl5SYRk8XA==
X-Gm-Gg: AR+sD10EChoqzOBN915jG5W69f3XRZCqGtlMIz/fwuUtO3lO+joAnBqIVE3aNyMKcZY
 esFmoDDKO43x3n6vMNHfkeASUx3QbiYsDo8hRshbosF3AH8QZt8rW/8k+9roPg6zXdf+Bg55pGQ
 23DIXTHE+2AIYEgPyT5CWHrfAtVlOtL0nWOA7dDUCYnpcdOj11XAXr8EiALWiw+5kRB9pUbi6Ub
 BDFC9o9qUeqdJ/iPgfQae6vl2XQpxJdbKk02diDo/ZweOUQcN1MFB/CEtC72Yv6bHAJTXK0nTQy
 jxwuRHzv9fJ+woAIechoLX/JyF+eb5zc0cQgTVruO/92
X-Received: by 2002:a05:6a00:b47:b0:848:56ff:6ced with SMTP id
 d2e1a72fcca58-84fc749497bmr4495492b3a.8.1786617005678; Thu, 13 Aug 2026
 03:30:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260806205449.16806-1-jerry.zuo@amd.com>
 <20260811003921.1398292-1-jerry.zuo@amd.com>
 <20260811003921.1398292-5-jerry.zuo@amd.com>
 <0102019ff114857a-259b7f40-8202-425a-bfbc-71bb92acf184-000000@eu-west-1.amazonses.com>
 <CAPj87rMSYC0wKP66p5Q5uOL+-Fb04-gYJFcRxdxxZ2-_du89GQ@mail.gmail.com>
 <e7bd40e5-b0fb-47da-aae8-fa16838f9185@amd.com>
In-Reply-To: <e7bd40e5-b0fb-47da-aae8-fa16838f9185@amd.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 13 Aug 2026 11:29:54 +0100
X-Gm-Features: AUfX_mww3yBHM5AmV0obwFDMSKP_QrJHvyHW5GJ3zS0Ihbtesai0qAGpr8B-AgQ
Message-ID: <CAPj87rMv1si7XBC4QRk_5yhn5+0558VTJnRq3NpU4pT-LqVz4g@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] drm/amd/display: Add HDMI ALLM support
To: Harry Wentland <harry.wentland@amd.com>
Cc: Derek Foreman <derek.foreman@collabora.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 =?UTF-8?Q?Tomasz_Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 11 Aug 2026 at 18:42, Harry Wentland <harry.wentland@amd.com> wrote:
> On 2026-08-11 11:23, Daniel Stone wrote:
> > On Tue, 11 Aug 2026 at 14:54, Derek Foreman <derek.foreman@collabora.com> wrote:
> >> Tying this to Gaming-VRR seems potentially surprising. Gaming-VRR
> >> doesn't mean we're playing a game. We might be using it to play back
> >> judder free video (where we'd like ALLM off to preserve the sink's image
> >> enhancement), or we might be at the desktop.
> >>
> >> I'd imagine some users would still want their sink to use all the image
> >> enhancements they saw in the showroom even when playing a game, so I'm
> >> not sure any kind of "auto" decision making in the kernel makes sense at
> >> all, even based on content type. It's a very subjective trade-off.
> >>
> >> To me, this seems like something a compositor would want control of with
> >> a simple boolean property.
> >
> > I strongly agree. I really don't want to see more magic implicit
> > semantics unless they're completely necessary for some reason.
> >
>
> Yes, though I wonder what's the point of the content_type property
> then. It's another one of those properties that's defined and unused
> by all canonical upstream compositors.

Poor old Weston, no longer canonical ... !

Seriously though, I see the point, I'm just really wary about the
kernel trying to be too cute about policy. If you want to use Weston
as a vehicle for an ALLM property, we'll happily give you one
tomorrow. It would be static as is all our current output
configuration, but we could also type up something easily enough to
implement the content-type hint protocol for dynamic use, with a user
configuration of 'enable ALLM if there are no games on screen'.

Cheers,
Daniel
