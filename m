Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C62CD6E75
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 18:53:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEB4911A258;
	Thu,  4 Jun 2026 18:53:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="gpMYDzpw";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0BD511A258
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 18:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780599230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XsZqKqQ5apgHHhOX9Ab/NdIUELyx46yV4YngdL7eMI8=;
 b=gpMYDzpwrZWJCin7WksmVeUcMZR9dZOzTFigOwHu8zHay1kHDuPKV5rjWMzJKNj1kp/xVR
 N+mB2ISyoVvoiaFKuF+1CVjnYA6DA/RxwKVwa8FZPgGXQHZQhq8F6EzsX0FwQscRMPNSMS
 6l9u/0FHz648je6aOmIvcV3bf+0WHYA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-lky7jlUQMz-7ax2cbwphWw-1; Thu, 04 Jun 2026 14:53:47 -0400
X-MC-Unique: lky7jlUQMz-7ax2cbwphWw-1
X-Mimecast-MFC-AGG-ID: lky7jlUQMz-7ax2cbwphWw_1780599227
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9157f1be04aso256562185a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 11:53:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780599227; x=1781204027;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XsZqKqQ5apgHHhOX9Ab/NdIUELyx46yV4YngdL7eMI8=;
 b=GT/QAwTECYVf+ftcuzUWZJVjdjxy/k1PW3IVxLwdatf6XLgdsivTsu/dDbgH4XhGMS
 DA7lIT8eWcQMzm1APemvVNjgeQ2NzS5gIruY2XY43it6rKTj7tPCKlYtE4ENxei6wKvR
 7um7rvFmMap5gcIvPtZv4RPVffQXLjkyNc7vkqJ6CW01QpGkydA6SffOVLm574pdYqlI
 1e+PfMbuglvYgUnVHCc65Ih4CRftC/bRSiCpJOmmXrZvUIUaJDbLlL943b5NJXiZgKVi
 Jvns+r5sMD74nMaNf90VDwx5KDUztqzDE76pak2O4HFrMQGk+Xq6RGAn2fGnDJ63cNEY
 UhhQ==
X-Gm-Message-State: AOJu0YyIrFcyPaRXAU9sV7WAYVMwKFnyqzLRBenznIcm+h2xNwh65qmR
 n9VXHcP266y0v/yVUC5cGIt4he94TfBRYOpgwetXNPbUJCIZ9yKYF0U5tw1Cf6Ja07fR966SE4z
 BvKVipQcZxRp3dXMLWMh87Hq1dhU8BAAGqm/ugWzRya2SRMzVICd8w2d4DtLOvfJj+KMNdw==
X-Gm-Gg: Acq92OHPTYJT1AfOIT9vbx+CUyYJO53aekA5Hx5x5bzwLSPD0MObaTY5paBYi+TexMx
 w3+aGR1Hk4eQ/AHVPLxqQt77A4tMKRMeU3vqzDm2E4I+tVd16y0iWihJItsWbjCregtK37gLxKY
 jANQuAJK/NeC9npvDTBTBb7Ak7AmtR7m/4dtkXC2CXOb2NNRhyzmk9rnoZiBCaUYSFiuKzIIw/8
 fXZ2DZQM5svrXSo3ZdC8FJ8rv7IOVHmO8WqXi01Jly7Ex2NGFHx3oI7NGw6iPNYjVOlMT34H+wA
 CcVDfKPGqRVRfVbDe/sjIHKjPfwwCF+of+6gGnLCbuAFncJlwCQmBqsdhhbYQkpkYoo7/pSXlRc
 rSHIskn5Hi1bPi/OgIms4mqJmso/R
X-Received: by 2002:a05:620a:40d1:b0:915:a51d:5ee7 with SMTP id
 af79cd13be357-915a9c496b2mr73287285a.8.1780599226706; 
 Thu, 04 Jun 2026 11:53:46 -0700 (PDT)
X-Received: by 2002:a05:620a:40d1:b0:915:a51d:5ee7 with SMTP id
 af79cd13be357-915a9c496b2mr73280485a.8.1780599226214; 
 Thu, 04 Jun 2026 11:53:46 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a237330sm683172485a.16.2026.06.04.11.53.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 11:53:45 -0700 (PDT)
Message-ID: <dacbea5b8b7c289cd467774c40f3d888a1f1214a.camel@redhat.com>
Subject: Re: [PATCH v17 5/6] rust: sync: Add SetOnce::reset()
From: lyude@redhat.com
To: Alice Ryhl <aliceryhl@google.com>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 nouveau@lists.freedesktop.org, Alexandre Courbot <acourbot@nvidia.com>,
 Gary Guo	 <gary@garyguo.net>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, driver-core@lists.linux.dev, Miguel Ojeda	
 <ojeda@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org, Sumit Semwal
 <sumit.semwal@linaro.org>, 	linux-media@vger.kernel.org, "Rafael J .
 Wysocki" <rafael@kernel.org>, Maxime Ripard <mripard@kernel.org>, Benno
 Lossin <lossin@kernel.org>, linaro-mm-sig@lists.linaro.org,  Danilo
 Krummrich	 <dakr@kernel.org>, Mukesh Kumar Chaurasiya
 <mkchauras@gmail.com>, Asahi Lina	 <lina+kernel@asahilina.net>, Daniel
 Almeida <daniel.almeida@collabora.com>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 14:53:44 -0400
In-Reply-To: <aiFoUauWYLz-Oyrx@google.com>
References: <20260603195210.693856-1-lyude@redhat.com>
 <20260603195210.693856-6-lyude@redhat.com> <aiFoUauWYLz-Oyrx@google.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IAaaJ3_lyw3ETTakqR9Ob8w7pnESKR08cWHJK4eHr5E_1780599227
X-Mimecast-Originator: redhat.com
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

On Thu, 2026-06-04 at 11:58 +0000, Alice Ryhl wrote:
> On Wed, Jun 03, 2026 at 03:42:34PM -0400, Lyude Paul wrote:
> > This function simply drops the contents of the SetOnce, given a
> > mutable
> > reference - since that proves we have exclusive access to the
> > SetOnce.
> > Additionally, update the invariants for SetOnce to make it clear as
> > to why
> > this is safe.
> >=20
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
>=20
> This isn't needed, you can just do:
>=20
> unsafe { (*this).sgt_res =3D SetOnce::new() };

I realized after sending this I could also just be using ManuallyDrop
here instead of adding a reset function, which might be a bit clearer
anyhow

