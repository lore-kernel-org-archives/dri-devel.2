Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCAACD5BD5
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 19:49:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA88210F5FE;
	Thu, 28 May 2026 19:49:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="LVmzChf+";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8B7610F5FE
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 19:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779997750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PP1ZQ9R+ns+VKuNnm+AdhqEaREMNY39Y34TAWM1PVuk=;
 b=LVmzChf+crIeX/3oru6X8w1VI3IQpbELjHFqIqizPhyPEoE9c1w4dGCzXZoNn/8zuIPLKw
 zwB2B+HrxbdnfXh8Iv5FaVsyD+k8jip2Tv4+gQDkrhAIkclpPvLIn0XCSYNK2jJ1dcXLRI
 UeJRicB3H1jd9PApW0qQXsQsqnEHqgk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-mAWFNrdcMlGgc_eqZUmi7w-1; Thu, 28 May 2026 15:49:09 -0400
X-MC-Unique: mAWFNrdcMlGgc_eqZUmi7w-1
X-Mimecast-MFC-AGG-ID: mAWFNrdcMlGgc_eqZUmi7w_1779997749
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-516ceea1984so142525701cf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 12:49:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779997749; x=1780602549;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PP1ZQ9R+ns+VKuNnm+AdhqEaREMNY39Y34TAWM1PVuk=;
 b=WlPaVSW0T89clrnxWKV7JKNmLPKaLMsEr6uJjhiax5jW8sxDw8n0DsBeKWjWoO1loS
 HmUYtMezBSiafF1C1ezHmyYp462C6eaJ834KlIMUhO2Qg07oIH/CNcf1qRGvzf1MkB9U
 MP5Bfmo51JhZPeFNfo/lojPqmCG4zLibKrXrATPbRbGqKqqWmi4MQn1WnlD3UR1LnnKi
 FUMn+1GFan4uPEoWYDHQQTBDfyZwEarlwmnhZr8WPk+Zt4qBnP33p2MubsHMxSgQwnO2
 vTRBRZMWZB+bhzte6qy5EIcwV2wNv29vdQivSfSx0rm7Va0tebzcFQVq4Nc8qeFAARel
 ctwQ==
X-Gm-Message-State: AOJu0YwV7q4JrvC6jwKmQIb6R4mtaJbPj6ZlK6wGxw7ujo8gmID/UwyY
 SD7EFo6oiQ/+xsRUoVtT1fc7E4iShDsjUsCWWFn6yAN8enM6vNvstrFBzLXghoYviU/Frz51caB
 3xf8uzrRjDNFoy+NUroO0vLYAl+qXVBpZQtvRETGJkmBqDl/tqPpH5OVwPCn97D3v5SSY0w==
X-Gm-Gg: Acq92OFxvQZy6Dns0Eq0NuKr+zA/xJL964SHvcPfo9MplPLSmjRwzn5QaejqW1PRRNT
 1Wv4aCl5tJXHeOKw5SrEeSvo5DOumJnsfLqYjumiu36J40QHVNduHhPnj9w5vTCEKvfPYHI0RJT
 NIio1yGqm2lJ5QcC9IdTMhxtlMYxdVxz5r0p/ctz5IkyGH72/vo/rWrihr0U8Vjbpn27X93UMmA
 e5AcM+4MB7XFTHFTGMahLERBpY6uPmKjpmpXoXTRygp8ORAEkgb0Uk7itaqfPRQYyV36AJlgYip
 9/KekLGF3uLwX3XUtXblw5JjXrEJzRXTlg4oel5UmNL2aCnLdveO3EdSdfXCsvCJIzjiBgsgUqP
 71GyXdI7vVt98S5QtpWXEhnRClJkk
X-Received: by 2002:a05:622a:260a:b0:516:d812:c35e with SMTP id
 d75a77b69052e-5172cbb883amr4075811cf.21.1779997748770; 
 Thu, 28 May 2026 12:49:08 -0700 (PDT)
X-Received: by 2002:a05:622a:260a:b0:516:d812:c35e with SMTP id
 d75a77b69052e-5172cbb883amr4075351cf.21.1779997748357; 
 Thu, 28 May 2026 12:49:08 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cc80ded529sm209836006d6.16.2026.05.28.12.49.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 12:49:06 -0700 (PDT)
Message-ID: <1b4ff2734e0c15448ab5c24a0800d20c24b25e5c.camel@redhat.com>
Subject: Re: [PATCH 0/5] Revert cleanups for IS_ERR_OR_NULL() usage
From: lyude@redhat.com
To: Danilo Krummrich <dakr@kernel.org>, Timur Tabi <ttabi@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Dave Airlie <airlied@redhat.com>, Qianfeng
 Rong	 <rongqianfeng@vivo.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Kees Cook <kees@kernel.org>, Simona
 Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>,  Thomas
 Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>,
 Hongling Zeng <zenghongling@kylinos.cn>,  Zhi Wang <zhiw@nvidia.com>
Date: Thu, 28 May 2026 15:49:05 -0400
In-Reply-To: <DIUKG7F2VAC7.17L4VHNNI7YL2@kernel.org>
References: <20260528192847.4077458-1-lyude@redhat.com>
 <DIUKG7F2VAC7.17L4VHNNI7YL2@kernel.org>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _jK4kRTMHnOzlhM-f1DjsbPrce4FfT07wWLEfH_eNS0_1779997749
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

On Thu, 2026-05-28 at 21:44 +0200, Danilo Krummrich wrote:
>=20
> I can pick this up later, but in case you want to pick it up Lyude,
> note that
> this now has to go into drm-misc-next-fixes.

Whatever works for you and is easier, I also didn't realize we'd hit
rc6 yet

