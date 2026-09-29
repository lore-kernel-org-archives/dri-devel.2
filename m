Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47635CA5FAD
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 18:48:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83E5210F02F;
	Tue, 29 Sep 2026 18:48:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WTIissi0";
	dkim-atps=neutral
Received: from mail-dl2-f41.google.com (mail-dl2-f41.google.com
 [74.125.229.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53FB410F02F
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 18:48:04 +0000 (UTC)
Received: by mail-dl2-f41.google.com with SMTP id
 a92af1059eb24-14b1b157591so23229c88.3
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 11:48:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790707683; cv=none;
 d=google.com; s=arc-20260327;
 b=NvZa0Yw6IHQW4R6RbN37h9FcrYLDHxJSLsnu4uP8E1n83sOSXi/70RTkZCfXOqVusm
 3KEvNaXuF3R60Ib+KgquK8mOkK4vPR/Ys6RlYgfZzMgthhK09UBzMJxL3jJLZn4wJwxO
 l2q1St/U+hRgvO/EwRkzfl/7JK53RxVR9MC3T3HdIhHU84DA5EmIK2FDwt2Ww1UfmwSD
 9k6dyVt2PJ6bFB46FTo639HhQ5GZuZDzeF1UiOczrH0NOBLb+oQKrocc9XVOs59ajqUI
 Q6k8k+HFby4lwOTThNRDjfGZhgNgjhjZhOs8urJQ7jkivftDw2/W9EneA09tHx2vlAyj
 lfjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4mXsG2n0x6/G8L81DtdCpyrZDoIOY4779O+uiKUC11g=;
 fh=eA//U5reaim0EHsSmdKmVZWcHUE4P+SRjuWph7yJF+U=;
 b=p/PdwJ7raOy5Dj6zyjdhE5PfXz/tOiZZmnu17iUXNZofq1Xa8L/rgE8MyjXv7MLut+
 TTogXZnOXBEB2Q5O2QjOCx+7BD700V1R3sG348GL5g8DWbcCdRA1sGbTGpCCrPJQwLUu
 yMpPiM+66cP7KPozcmbH0lNms25dduOKW/GDi2YMoFGGz42+b9Zj69MHNz8lHLJZyY+f
 3By1O9Lg2DMzuryAVRrExl3lBOvYRXIpqofNDIBXihHfQ6UjDzyGNQAxtjOnB3Bi/yyi
 9vA4PhBFMcm3zfob/1dkjhAhoeg50RZMBm6C3d9aFRNNeiz3OAxmo/8o4A8Dcl6AgHGb
 aM9A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790707683; x=1791312483; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4mXsG2n0x6/G8L81DtdCpyrZDoIOY4779O+uiKUC11g=;
 b=WTIissi0ymKZVWRrUbueGmZxD/GU55zjWk6vOYLmxWK9qgjytPlm9Ozj/QT9kV0Zqs
 J0PLUIUnWT0UCGHttcccHjBBF4PZ7SPy4as2FOZ0/nGbuCZNW9qyZdHy+jAT4RuxP6Eb
 Dev4ttNmJPY8K2URW3wReoj9R7Kv4mP8Tui5iBzcY8nAcp8StYiJG7jUd1TWbTfesn6O
 z3bDab55xEDYC6XNyJGbiEtrZHuWyoKNXD6MDO/klanOev1LC0F3iToFgkT3ryOnAFPo
 khPzBU+oLJXEEghFeFsvFfSY2lfW8c7kSEqoGngatnV+KKWYx//60nHx3YZfhYTjpi+R
 2Hgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790707683; x=1791312483;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4mXsG2n0x6/G8L81DtdCpyrZDoIOY4779O+uiKUC11g=;
 b=vBU/PgxgPeMd8Rj30NEt0xo4jczY/qmsDq4p3XNWFTSufiS+lJJmyTRxX0YldsJ+sq
 TmdIyL4qzPgZcCQiIU1QhVRZE33x2wohlMHJXKLva5DHHQsQ7sDQePlACf43KX+pD/rk
 pjlBVT0Vw2Ept/Xs2QwsNEvBKpZhpxOgY+H3s8r94Amsm0LTaVZw9ku+KuxvOiTttNb8
 kjxxKi4cHy9/Bjv+ey92N9WJxLdqSjynUxNfSNZo4cwy1hHsXD78+/d/69NfQt3IFzvi
 H3jwo7UYnscpk1jz9pSyNjEUSZv+tsomuGFUOBVUgrA8onri0llYarYUOSevoQ+u5kSe
 hHkA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwksfjAZ0ia0J4uuZTrx20TtcVuL/NV3tNN2SK4vVtcEEiStOGhExGwzNdMiUTZKybmJTxG/+mybI4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIqebVBC7vzlQskid1Kct41vo4AW76o1mRT0oKDolMmUDDmBDHF
 1OV9Pj1sL+6jRyRRbrRMdrB3zeXpzI0QZRzAXJFUpkHR+FBF+qkH5LzlpeEmKcU/hY6W6BeO0fY
 yIdt+KUmLHnpE1fdxfmKfQnD2SF9UeUU=
X-Gm-Gg: AYBFou1oJoIbVl2caSAiAY2GWXpO0mRZBPIsIlwku+vfySHbUzxRfadQef48em30WUo
 kPqr9oQsq0wqQCZEDtSFy8cs/WX3DDZaEo6yHPrErlr848i56rhIKO0SBIuWrnhzLpn2qTeoyTW
 MJQr6XkKNoIw+gM4QKtmGh0tByoghYBVmrT65cup/7TXTdSe2q6vH/lHz+6vljBU0whAfon2SOO
 y7QEfM11ENO/3sHT8V8dEZnoVJbRCAoQXhc/B3QFl3UNaxc3JqOwaARRGCgNhQ//nzZhDZZWG7G
 5+c1xp9fCOCEIXVV6Fu/5aztDjs4zA46RBYzMLu2kbdzo82AHlV15jyFDKOkeCRSdRUdiOq3Rxv
 z7w4IAspkVmXq14Iryyrz1/n4nnpG2hrho1v1eo5D3N64znO6vccKtDpKffzegpwW0ithjNO5rk
 yO0tzRdLM91QOVRJHIca8IEy3Wzt3IgfiB07HfqPq8T7ryKpT6JV0=
X-Received: by 2002:a05:7300:d0ae:b0:34b:101f:cdaf with SMTP id
 5a478bee46e88-34c65a6e7f8mr375267eec.1.1790707683419; Tue, 29 Sep 2026
 11:48:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260929135855.36775-1-chaoji_xinren@163.com>
 <20260929135855.36775-7-chaoji_xinren@163.com>
In-Reply-To: <20260929135855.36775-7-chaoji_xinren@163.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 29 Sep 2026 20:47:51 +0200
X-Gm-Features: AclHuK863ebGI2IXnXKyI5Z8WG1aeHKK_SaCRYSny_74NDfJ3eAdiAl5z7WrHIE
Message-ID: <CANiq72=ciUBTJJ=SvdrGBpNp3GvzA_m5NGeWmuCgypkFA1i-LA@mail.gmail.com>
Subject: Re: [PATCH v6 06/10] rust: macros: exercise the intended conversion
 doctest failures
To: Kaiqi Guo <chaoji_xinren@163.com>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
 Jesung Yang <y.j3ms.n@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>, 
 Danilo Krummrich <dakr@kernel.org>, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Charalampos Mitrodimas <charmitro@posteo.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Sep 29, 2026 at 3:59=E2=80=AFPM Kaiqi Guo <chaoji_xinren@163.com> w=
rote:
>
> Suggested-by: Charalampos Mitrodimas <charmitro@posteo.net>
>
> Link: https://lore.kernel.org/rust-for-linux/m2qzr81jrd.fsf@ip-192-168-1-=
196.ap-southeast-1.compute.internal/

I have been seeing more and more lately these newlines between tags --
is there perhaps a tutorial out there mentioning to do this or a
script that ends up splitting them or similar?

It is especially strange in cases like this one, because the Link is
for the Suggested-by, no? So logically they should be tied together
(if the kernel allowed newlines to group tags to begin with).

By the way, since I am here: it sounds like this could be split into
different patches, although it is not a big deal.

Thanks!

Cheers,
Miguel
