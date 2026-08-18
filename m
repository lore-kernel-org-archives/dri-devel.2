Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 677D7C5DF81
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 22:32:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8A7110E3CB;
	Tue, 18 Aug 2026 22:32:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="GhhRRYgm";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B73810E3CB
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 22:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787092362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sTUm+GAgh5332QrOBQAb36npGn/mxQsgSbSIFRFLtWk=;
 b=GhhRRYgmqDY1OWnltaavgKOXRLqWFddcn/wRznuqx3doRQdC3rd4b/JCsTNWnB8CGBYfSa
 h0DUMZn7reSM4a8/eqZo1BicFosaBC43kuIhdF+BraypwNZfHqyGRb/Mdl50XyXIiw3da6
 spXVyHy+ROKC4GbxrffzC9g7Mq1ruMc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-TTJjhpKhPr2WkrVLV6Ojtg-1; Tue, 18 Aug 2026 18:32:35 -0400
X-MC-Unique: TTJjhpKhPr2WkrVLV6Ojtg-1
X-Mimecast-MFC-AGG-ID: TTJjhpKhPr2WkrVLV6Ojtg_1787092355
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52d28f8737eso5723031cf.2
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 15:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787092355; x=1787697155;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Riz2A5UuSViG3JVLoC0bGAkxf2EfZnfcPl3QvTwCNF0=;
 b=RYRkwXSk5qZ9YHCfcg3WW2T1kcofWzzDGc+WnDS/tLFpzGB1Cs5Ug0XvuwjMbCzB/M
 iyZssnyI/lHC9k5bOCLw+GGL4n5KYdorfCI8Fu3O7VkzVOqMu9e002FNaNBt6hAj/J5X
 FkFfy8qlu2iEsJrtEbxLuZ2EFCqjqHtNBB5mHuUjbPCfXzASjgbIhgh4KQ5bOQT15cgK
 9Spl4066JUVU8T5NvsAiYl+K8UrJl39g1tXHwd3ML0bqt07kigY1a8Nd5oFFWRsNnh+D
 P/d4Y8+neKoQrJajUEAy6qSxr19Hljb0HO/x8ZqPve0l1AMP1auslTqPHbuWg2o9yFiq
 tyeQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqLw+IzOtDgtnOGXfs6kV/uO/KJkL32OEhp2aWzwMGExiOyFmvhUAO0Sx2/2IQ5K1krhAZc/NzgGAY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzsKTRwoFbtpe7BrbW4OJTybkJopVsl3tJKBR+6h+bw34wS9eFy
 COneUYQr0ysi7v+GqksNT1pOcFDnMI/Uftd/zthb7sk4ijxyUwLkaq9FfrIb7O9Bgd4iwEGpgH3
 cYSzDLfXmn+x6HyovRgtJBNnIYrA6szgTqM3Sp1j5iHkHhgYfDRzDCm+zAqlAgf+a8QIIgQ==
X-Gm-Gg: AR+sD13fSsRMALkxS1cy0JcOZotCnYeNWOWV53aN35PbveQ6aNYkGEKHOovMDWuSAIt
 1XXC0hnttvCJIA/tOYNyfgorAfIO6YrayOwJ50/HRdcA2SsB3NSHHpVv+3XD0h83yhCGW6uaeLb
 TPuAHNVuBwLns436QPQDNEI4yUmdnkzc1m7x4pxiZRDYlcbuR9B7u/CsOR+Dr1V/F5CI7/K1ECJ
 c9Ci0ltA3UaSu0ZBsMPptedTS36rtYbo9ExihNrT555qTS4ULLdsXNjBwaWu54Cb/yv3dhhNp6L
 PYeKYQGnUSEyX05SmSbW4C97sm+bzPTd503AwoxLbkOMLuLq2HYVT+AnRB0qZ/IHidI6F5eF
X-Received: by 2002:ac8:7f41:0:b0:52d:918b:92e9 with SMTP id
 d75a77b69052e-52dd5cb02b9mr4146971cf.33.1787092354684; 
 Tue, 18 Aug 2026 15:32:34 -0700 (PDT)
X-Received: by 2002:ac8:7f41:0:b0:52d:918b:92e9 with SMTP id
 d75a77b69052e-52dd5cb02b9mr4146391cf.33.1787092354173; 
 Tue, 18 Aug 2026 15:32:34 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52db60eb025sm49583821cf.5.2026.08.18.15.32.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 15:32:32 -0700 (PDT)
Message-ID: <4b354d80857386b0dfb4b38615d707f6da65b66a.camel@redhat.com>
Subject: Re: [PATCH v4 2/2] drm/nouveau/kms: guard NULL crtc in
 nv50_sor_atomic_disable()
From: lyude@redhat.com
To: Marek Czernohous <mczernohous@gmail.com>, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Date: Tue, 18 Aug 2026 18:32:32 -0400
In-Reply-To: <e428a3e8d4c0500c112d8deb756fdec884790623.camel@redhat.com>
References: <178688574400.522643.6695278742335367229@gmail.com>
 <178688574402.522643.5471719764843371376@gmail.com>
 <e428a3e8d4c0500c112d8deb756fdec884790623.camel@redhat.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: O2bc4VyQ6DwvYhnsuiJi3bYTnILBGXxusvUicHe77hg_1787092355
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

On Tue, 2026-08-18 at 16:44 -0400, lyude@redhat.com wrote:
> > +=09 * .atomic_enable (and by the boot-time hardware readback)
> > and
>=20
> We don't set nv_encoder->crtc at the boot-time hardware state
> readback.

...this was wrong, oops!

