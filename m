Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E938F8D75C
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 19:44:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53C3410E2C2;
	Fri, 17 Apr 2026 19:44:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="ScaF/hWL";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A62810EA99
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 19:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776455069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4AUae5KcEeFvFh3msKQXl5hQJhIopamMvxo6YZ4ukss=;
 b=ScaF/hWLflWAYuk0Z4w1zIK1BB61+gW2jXF0SUApYSVe4x6/DlccDRXxhm43jDEX7nGOx9
 zpJDpXFvARmjPhSqh28hZWVRlV5edsVAyQnK5OAATzw/144O3EdunQlqWyGIvYlNIBil47
 UtPKuX9K10QLLhIKOqjAgb62EcvYM1s=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-Z5nyApH2NWOzbSjWJfUXSg-1; Fri, 17 Apr 2026 15:44:28 -0400
X-MC-Unique: Z5nyApH2NWOzbSjWJfUXSg-1
X-Mimecast-MFC-AGG-ID: Z5nyApH2NWOzbSjWJfUXSg_1776455068
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8d5010ea730so552429685a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 12:44:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776455068; x=1777059868;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4AUae5KcEeFvFh3msKQXl5hQJhIopamMvxo6YZ4ukss=;
 b=mIlUQYS3I8QGdMryspf2V4/YTy9fMo1wJPzLhuWSWyo0i/nL/I+B8Rob976u0WQqv4
 dBpa0oNRWM8gLr/gc72Gx6rZUl9+0tv4fo5LFbC08XoA7w9If6jUAFysOePO6YZlneQ3
 oEcCYRYCBVA6Rt+88iOHTRsenjDJ8iZd+MMb+wAZzUZMbhsuM4+/KKBMW7ldcwenVReQ
 k79h1tB41anrBVAcXtwlvELF7QdoaCxxvt/gAL4IPXVwQ7LjY7If1H1zvSwISiapwnqZ
 E+5lPwIt2XBwuTKFoYk9pAXmPAVunj5arSU4LTybtA62JtaMQWxXcFSFdu6JVHdOWCe6
 kTNg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/kiuooYDXvMZcp8gOa4pE2kwfKvRIZP7VbK+eHG3kfPICe9MHhVTEJbZg2eswNj7Odzl6IOGR+Nbc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwzHr8BSr6nHDgbnDejWyikqurpEBYuwjtVKVDzX1BZiACMVlV4
 LjcHWtBtDRu8jiCwmZMSREws8FeJYaCh6YceVY+hv82K9zxKhKnG2j3OUHnvPksVNzvK9ZGCFrR
 fDlIV8s6y9iklbQ8vPscM+8nMqyHOHVvL+PKNxnW6zZ/DayFzS5jCjndSlwbqoj1S4/SnBg==
X-Gm-Gg: AeBDiesZ50SPatyouy5aQjOUTknGUSW1FxvBki/ulXaPd/ZSrf7YGZtyQuZvaOmhNbe
 02bV9E9RtKnPVlx7kOWaUahor1mbFRq0xmzLhTCKg2Jooa11dBiJiEjjpfEBxQIIxo2fLn0gtVw
 lpzugibfQ61S1UzOShl2u7P/fhvBt4dg2T/RYHmibkCbL89E7Q6IwDQ5vfeT6MdCaXfVl9iQ1Jc
 0LmsojxzgOSZbgqhhqzAWlrSdsOTq7/g1ZY0JMkG4/CkweKq6P4wBJyI32ghyZWXPM5MY0/bUvn
 A+MjupJcyn/N2uOMKHCObUvAR881FUNfF4O/y8pCFZs2alv8fyeI1YpTrhmoGE288/tTePYe1xi
 CKiILLj2IwbCQIWP/zB8GqKCwR/cM
X-Received: by 2002:a05:620a:4408:b0:8d9:ca3b:5ca1 with SMTP id
 af79cd13be357-8e789c5ab1dmr528961285a.9.1776455067627; 
 Fri, 17 Apr 2026 12:44:27 -0700 (PDT)
X-Received: by 2002:a05:620a:4408:b0:8d9:ca3b:5ca1 with SMTP id
 af79cd13be357-8e789c5ab1dmr528955585a.9.1776455067197; 
 Fri, 17 Apr 2026 12:44:27 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e7d9abce59sm243352085a.46.2026.04.17.12.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 12:44:26 -0700 (PDT)
Message-ID: <ba9d6fbd12a42d95e6349e232111d5e72e88e1d3.camel@redhat.com>
Subject: Re: [PATCH v10 4/5] rust: drm: gem: Introduce shmem::SGTable
From: lyude@redhat.com
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: nouveau@lists.freedesktop.org, Gary Guo <gary@garyguo.net>, Daniel
 Almeida	 <daniel.almeida@collabora.com>, rust-for-linux@vger.kernel.org,
 Danilo Krummrich <dakr@kernel.org>, dri-devel@lists.freedesktop.org,
 Matthew Maurer <mmaurer@google.com>,  FUJITA Tomonori
 <fujita.tomonori@gmail.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 christian.koenig@amd.com, Asahi Lina <lina@asahilina.net>, Miguel Ojeda	
 <ojeda@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Simona Vetter
 <simona@ffwll.ch>, Alice Ryhl <aliceryhl@google.com>, Boqun Feng	
 <boqun@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Krishna Ketan
 Rai	 <prafulrai522@gmail.com>, linux-media@vger.kernel.org, Shankari Anand	
 <shankari.ak0208@gmail.com>, David Airlie <airlied@gmail.com>, Benno Lossin
 <lossin@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
 linaro-mm-sig@lists.linaro.org, Asahi Lina <lina+kernel@asahilina.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@vger.kernel.org
Date: Fri, 17 Apr 2026 15:44:25 -0400
In-Reply-To: <DHPBAVQHIM11.XVBHOWYFRITF@nvidia.com>
References: <20260409001559.622026-1-lyude@redhat.com>
 <20260409001559.622026-5-lyude@redhat.com>
 <DHPBAVQHIM11.XVBHOWYFRITF@nvidia.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CJXNHARne3AVF6Bex6vIJrekYHjxzVFS4WgPfKylhm4_1776455068
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

Just so it doesn't come as a surprise in the next respin - I don't
really see a reasonable way of using get_or_insert_with() here (though
I had no idea this was a thing!). However - I can get rid of all of the
ret =3D statements and also clean up the indenting a little bit with
block expressions as I forgot those exist.

On Fri, 2026-04-10 at 16:55 +0900, Alexandre Courbot wrote:
>=20
> nit: let's use `let ret =3D if let Some(sgt_res) ...` to avoid the
> multiple `ret =3D `statements?
>=20
> Or maybe even better, you might be able to use
> `Option::get_or_insert_with`.

