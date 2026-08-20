Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69851C5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 18:26:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9A6810EC16;
	Thu, 20 Aug 2026 18:26:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="aWrgBZ63";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ADD910EC16
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 18:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787250384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0cPAiw8SZK4VJABSJWXID6c8H+dfAlzI9Es1HSEj/Po=;
 b=aWrgBZ63hOukYUxN/qw+83r4nQo7n5usWd7VBS38mhyICT2bdpjrg9yUDtdRQyfhpUHEi8
 TnH9nJDR/ZIcGhC1aCdgQ/vREfo1Am5GRWal1Z0jwoCkON7ETjV/q3t1eFptIsZ7y8UCt2
 X+qixIu1+qMnocs+Uw38Mj7XqEaUX5s=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-ZqNUxeGWNqOLKAOWqwqnHg-1; Thu, 20 Aug 2026 14:26:18 -0400
X-MC-Unique: ZqNUxeGWNqOLKAOWqwqnHg-1
X-Mimecast-MFC-AGG-ID: ZqNUxeGWNqOLKAOWqwqnHg_1787250378
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92ec3146553so20092285a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 11:26:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787250378; x=1787855178;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0cPAiw8SZK4VJABSJWXID6c8H+dfAlzI9Es1HSEj/Po=;
 b=muX6HpH+06kos4gMmRKYm1cEj0gMnyMW3/9Z53Hvhlkdv/fC8Gz3y/3juPWyL30mfm
 ncVF3RYQDarsGWb/dtT0HzKbKf/qSJ+GoAw5G7L8KrP5W1KNVh/epdaI+EMMLD4Cdd1r
 gkkcI87orFN1EpJic/Ewr914RDKHORpngE0CCVU8x2QVcRZ8xeEFjSsz06lStQG6wvRf
 VI/PN3E1eSQi/MzYZYbFjTRYKK1L9CwQQfUsATjHCpP0b3GFK7TJ/4DS9qITzLFZLAmG
 x63NpZFyibsdkkl0zzcUytxzdYjQHoj22AHVJbVnuRYxoWvD/6NS3RvNb22P58/jDiQI
 nqaA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqP0MXVpd23ZJuE1rtwbDzyAIJRFXs24uBmAf1DnaN4vacVPayxagwb99/VfDmx/rGjUIa/f/tSNyY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw6djxaYj7xP7/ppxz99kGYMZiF8oTN3Q4gWl5t0DQ5WXSzm99d
 Q3fh1HQz9sX+LDKkn50/QSwl2DPCT8fXh/QNKwUEsP7JUkwF9/xRE3lIlK7gzzbvYYQ1mZS+08r
 792fF8HxQiK1hgzW4eOKJ1cdTFIt2H32DurXOpU8mPgo2gx6fWX5Mmyh45B89E73VNMLu/w==
X-Gm-Gg: AR+sD12rrrYoczJbDNQ/+FW+H4UqpDt+JNQ5CFtpsGrmXnCJ3r6U3zP27dSS4NHnOKs
 HvuL7n/sU3GwMYknDNv7bcbWg6mR/fqCaG8mc+E1oFmet9jpCT2ZELlmcDuA9KlIQ6i3VJ5Tp3g
 Oo9qTHdJeR7zPefAnc7v79tDjbW5rCpbO+y8WXRxlJnXSWJFpSXe+1R0zfR8UjOlMIQxFthcaf2
 1BMBBGouPO8B+mg5w0wB1NZZC9cszSUlHCJmFtuOaN5HhMCT28790CHUA7JIi03AFtBOcj4I/N2
 y88jC3SHnAM7UW2w3/c0C2kdGDM7SwK7CdJuJP9HGJLB+frZeWH8NRODJqgdjimwg0cKgN3Q
X-Received: by 2002:a05:622a:54c:b0:52d:8275:4557 with SMTP id
 d75a77b69052e-52df5ba06camr2537251cf.42.1787250377959; 
 Thu, 20 Aug 2026 11:26:17 -0700 (PDT)
X-Received: by 2002:a05:622a:54c:b0:52d:8275:4557 with SMTP id
 d75a77b69052e-52df5ba06camr2536701cf.42.1787250377424; 
 Thu, 20 Aug 2026 11:26:17 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c5f2b5c7dsm44258136d6.47.2026.08.20.11.26.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 11:26:16 -0700 (PDT)
Message-ID: <1714a7c2142ac27fc5142584f0a61e9e8871831f.camel@redhat.com>
Subject: Re: [PATCH 2/3] drm/nouveau: cancel the DP IRQ work before freeing
 the connector
From: lyude@redhat.com
To: Marek Czernohous <mczernohous@gmail.com>, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: sashiko-bot@kernel.org, linux-kernel@vger.kernel.org, Danilo Krummrich
 <dakr@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>
Date: Thu, 20 Aug 2026 14:26:15 -0400
In-Reply-To: <178682657122.3795552.6920623796751043528@gmail.com>
References: <178682366001.3748010.7798811159846779765@gmail.com>
 <178682366002.3748010.4096452389040554615@gmail.com>
 <20260815201130.7BDDF1F000E9@smtp.kernel.org>
 <178682657122.3795552.6920623796751043528@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: f6gylKrRP1CR4-xTMQKh2p6-AMQySL3mrAWQ123vOA0_1787250378
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

On Sat, 2026-08-15 at 22:42 +0200, Marek Czernohous wrote:
>=20
> I cannot rule it out, so I should not have written that sentence as a
> finding.=C2=A0 It should have said that I looked and did not find a fourt=
h
> patch, not that there is none.=C2=A0 If the maintainers want, the shape o=
f
> a
> fix is probably a drain of hpd_work after the connectors are gone, or
> making nouveau_connector_hpd() a no-op once teardown has started, but
> that is a separate change from this series and I would rather someone
> who knows the hotplug path weighs in before I write it.

I wrote a lot of that code, so I can just send out a patch for it in a
moment and CC you.

