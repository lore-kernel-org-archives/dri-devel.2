Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C241C531CB
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 12:06:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F9FE10F0A5;
	Thu, 23 Jul 2026 12:06:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HTSiVbx3";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DF8910F0A5
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 12:06:26 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2cf30af983aso1511155ad.3
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 05:06:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784808385; cv=none;
 d=google.com; s=arc-20260327;
 b=r+DwoE6pCrez2NJlS4vnmr0lyvSwa860jkS4fSzrs3hj/80S0EfuTBQ8r7IStE1lAD
 i1zICXMWUmMoDEeyahJyT9Kx9sxn9X/Ag9tPJ8PY/YlOvtfhJbafvqXKkRyL7U0kXhwC
 WfPYZcLZUKYfSZFyekybt8F6vPOJoeUXLT10Edb3O+mRImUmLVu9osB+4KUQgeQMkd3Y
 3f7pvweYWXcZSqhi96U0+Ktyg11NmEXJBK5bJbsuzsPMjOBCGkZPwurnTraoDz7EN9mr
 BItM6rizvV6W2dKybXTmm3chhR1Wk3xNlWS8CyN6a8X3LnFM7B/Zqjy03ZTsaO3puK7v
 yXOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3vlJv6FSf1aMVbnSCASc4/+DJaUBunDB2IB1X7BaEeM=;
 fh=8hGTycFFdOagKM03Y80CLTLHErqEpFaX/6b/I5Lg94g=;
 b=P4fQH7CCzPLJssGnlx6IBL/nYbSf3rzPSwZEkLRIAnBHGnWFdp/yfwSBLWqtNsXGxE
 nljZyLcP+W1qOe6VbvOJ+aENr2Yk3mXmlEy3aYTzo3FET+IxYLpiBjpUWwsWrCLmEKna
 6cxPuO6QXxaCqzll0swnAEW7m5yAMU8V3ChCzBG7SLjl93psErHPGuv/uibxlvMpXA+U
 4niZbyiSf4MFIkDj4yoc8ar3s0917vtXPTXhUNnP0j+d0CLzVFweS4VAJGO9mpE28RCB
 +AvHEixeOxng0XVfSO6/UZbWevFfdA7bB20RzX4RIYL1xO2aavFFNRiifOgSvsBYP/Ho
 V0PQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784808385; x=1785413185; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3vlJv6FSf1aMVbnSCASc4/+DJaUBunDB2IB1X7BaEeM=;
 b=HTSiVbx3qgEoUccfslSo1OZsp/l18jQrhQSs4zEud6EhcMnaYBerRLu7MwUUsYBYZE
 Xco/1rCpEaESuRAcRCDQbUCVNSEiIWxRlYoTiF5jDzS6AWevYp/Jsi1q8+EHQv81HrXO
 g6atwTVqnkQBzbKoD442O7WMAQcNBqQfQDOC5qqG0NgsmAY8h9YFeTY/zOb5LWBypxTU
 lUhGiuA8hmkx+MeJIF8z+F7/xqx4wfo6O3llRui8aub9YQQ3oX/pB++fXs8GX+kFL2wj
 1cHJmKmdAQjEjr/9KZZ6+j/KU1QfuOduOa1hnO9y/E3oxmMRykwkBnZWCHLGQuVb6WPa
 u5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784808385; x=1785413185;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3vlJv6FSf1aMVbnSCASc4/+DJaUBunDB2IB1X7BaEeM=;
 b=NfJO7lOcGaVWk0KVsxwrQt+mCV3QC7hPsLV/Szd/zjiOQa2UoDLHrpjF+PsGV6Nlsk
 WUazaby+ueLIhEpQljJGhxpA0GQ47Yz3syMcWAH4PEdBKgph2LhKCn+xg+X0Rqj/mINw
 4w//LKZKXJkXntwKb14EmU6sJSbcFkKijHAj+8HwJcvtLR2r8hh75qeE8oQG7h4gDN3h
 EP4wJ5eYrsTb+OzByweJ0K8cAAOojY0Q1MsLlnOTdBIlp5lfzMidQGlDbirMU4Ye/JEi
 NrFqyJ4H7/OuBlj6pYOg0V9809f6BJwN8i8h//nGB6JhZUeJh28H2tA42zCZuNP3leNk
 bZoQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpsyHH2cPaaDdBwKzES2AfOR2cap/qnxlbIt6rbFEr+feKUKt/L1h+W6E1kx0/mEdm9Lhy/z+xpR0s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzS8AowNgCDKP7J7QD8pcSdnQ3335JLviOpnNHn2UJ474DYVq6H
 xT9AKSFcrWshjgyMcooTahghOOz8A0RRG22oJAHGfcHeGQtj+5rtDUuBSL/pfxg70i/fUWalqm5
 +YdZwQUA+xXxm8/VCLcIJwBl6OwmGuA8=
X-Gm-Gg: AR+sD10x25uk/IdggwTnhcswjewIRKhBSQUdTYlX3tiiZA0UoK+hgyCdx7pjjobRWgt
 80mHFoblEfNRlcmzQpm0O1PWWKZJby4Hechv1pFbecoSiFUmddWWKT3rO2+oCSHr38dfNMysTXF
 zwbdq8jD0DuUozOPvSM8x1r3WnJTZjLHyn57nC8XEKuiOZCKE6h+fUBYeXaMEsAQb5qtds5aa8B
 PKsEjlSOAv2XLEN/jvM8LMfZaT7nWWQAQF24/Wc0cZ5q3P2kJFQGcYhnj9UYzPse+dtPmcXWzvj
 RFt1T+/Tr9crTuWC0wxn3Ndu1v0q7wRYD+w8R5Q9lCu0u8391aIskGu1ecj/LbnzIwf6zCkhH7p
 eVic8iT02P9Vi
X-Received: by 2002:a17:903:4b2d:b0:2cc:e3b6:f305 with SMTP id
 d9443c01a7336-2cfa6c59d68mr27112065ad.4.1784808385545; Thu, 23 Jul 2026
 05:06:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260722144931.1070312-2-phasta@kernel.org>
 <20260722144931.1070312-4-phasta@kernel.org>
 <fdcff2949180fa40d0605866fcb306781ddae4cf.camel@nvidia.com>
 <73981717a8a609013eaca197a41a741c52bff44d.camel@mailbox.org>
In-Reply-To: <73981717a8a609013eaca197a41a741c52bff44d.camel@mailbox.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 23 Jul 2026 14:06:12 +0200
X-Gm-Features: AUfX_mxFlBb9IDtLvxq2VlENXeNPc_YmNc4BAainSjkN3awVvg2ldaZORrjacic
Message-ID: <CANiq72=zQkkQWedVZ-rtCeJBbRxhwNJTLxCBD-6um4OMuFJGGQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/6] rust: error: Add ECANCELED error code
To: phasta@kernel.org
Cc: Timur Tabi <ttabi@nvidia.com>,
 "qiang.zhang@linux.dev" <qiang.zhang@linux.dev>, 
 "josh@joshtriplett.org" <josh@joshtriplett.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, 
 "delcastillodelarosadaniel@gmail.com" <delcastillodelarosadaniel@gmail.com>, 
 "a.hindborg@kernel.org" <a.hindborg@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>,
 "adzicmirko97@gmail.com" <adzicmirko97@gmail.com>, 
 "alistair.francis@wdc.com" <alistair.francis@wdc.com>,
 "ojeda@kernel.org" <ojeda@kernel.org>, 
 "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>, 
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 "yury.norov@gmail.com" <yury.norov@gmail.com>, 
 "tmgross@umich.edu" <tmgross@umich.edu>,
 "frederic@kernel.org" <frederic@kernel.org>, 
 "aliceryhl@google.com" <aliceryhl@google.com>, 
 "daniel.almeida@collabora.com" <daniel.almeida@collabora.com>,
 "boqun@kernel.org" <boqun@kernel.org>, 
 "lossin@kernel.org" <lossin@kernel.org>,
 "bjorn3_gh@protonmail.com" <bjorn3_gh@protonmail.com>, 
 "neeraj.upadhyay@kernel.org" <neeraj.upadhyay@kernel.org>,
 "paulmck@kernel.org" <paulmck@kernel.org>, 
 "rostedt@goodmis.org" <rostedt@goodmis.org>,
 "dakr@kernel.org" <dakr@kernel.org>, 
 "tamird@kernel.org" <tamird@kernel.org>, 
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "lyude@redhat.com" <lyude@redhat.com>, 
 "lina+kernel@asahilina.net" <lina+kernel@asahilina.net>,
 "ljs@kernel.org" <ljs@kernel.org>, 
 "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
 "work@onurozkan.dev" <work@onurozkan.dev>, 
 "urezki@gmail.com" <urezki@gmail.com>, "gary@garyguo.net" <gary@garyguo.net>, 
 "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>, 
 "fujita.tomonori@gmail.com" <fujita.tomonori@gmail.com>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, 
 "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>, 
 "rcu@vger.kernel.org" <rcu@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>
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

On Thu, Jul 23, 2026 at 1:56=E2=80=AFPM Philipp Stanner <phasta@mailbox.org=
> wrote:
>
> Ok, pulled it in my local branch for now, thx for the heads-up.
>
> I see that your patch is from June. If it lands in drm-rust-next
> soonish I'd simply rebase.

I will take Timur's this cycle, so it should be fine either way.

Cheers,
Miguel
