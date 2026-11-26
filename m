Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A708B606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 10:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Xv6NgdYJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E6A41122D2;
	Thu, 26 Nov 2026 10:41:43 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 600BE1122D7
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 10:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795689695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hTXpIfLZ2+j1ow8NmZB6JM/DU4spl29LunD6FR84AzA=;
 b=Xv6NgdYJNl4EH1DzKAF+Z8SVTsfFT74WwhR6Pcsq+y0YXBVzLprPdmVX+sVruwI3sNJZEO
 uxjUJw1SbjFSlpEsoLHcSspVdxNutMcmdBZL8TZ458bRLR6xMHqoyNktJeci2HyoKHJbqZ
 uV9FF1uCMVSxcHtJIcN3TbHpsaxMA+E=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-D9IB2y0SPhq6ZusYHzVnFw-1; Thu, 26 Nov 2026 10:41:33 +0000
X-MC-Unique: D9IB2y0SPhq6ZusYHzVnFw-1
X-Mimecast-MFC-AGG-ID: D9IB2y0SPhq6ZusYHzVnFw_1795689692
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-c504b52eed3so667284466b.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 02:41:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795689692; x=1796294492;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hTXpIfLZ2+j1ow8NmZB6JM/DU4spl29LunD6FR84AzA=;
 b=IzWfoRG10TSMwmIMR7gtW++4Eqi3bxgMcpN4sV8mIKFHMeEm5sfEE74tfK7EislgkB
 NXN2Yh8LU1MGAyljtrQ3lUACEFNhKlW5pfsAFZgIlM8wBcxu6RSau3vn/kwVUcJr35k1
 mQQ/NIV5z0aXZ6eZGDcoDKZVnsKVUTnypLDUxNCtNrYdtZ4gCoBDUeETxJRjbWq8L1nE
 YYaoqQMjgwRl6BdqWqshFJ8huDthRFfb5etwbemfc1OiegbY/2LwLxALHSdRlojXWoyn
 tnPEX/UfSuNWBWh9VWOIGQm7+dF3S590C46gh7DRIMi2dmz6LdJ5EYKKH0GEVNiMjQud
 a5Kg==
X-Forwarded-Encrypted: i=1;
 AL+hErHmCQByLLpCsSgXwJVBp8zQusjhpC7bqcWI23X+6P2T3Z132YuKniiPv0T6NxxjXa+M5LllANyl1iQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9yHZQ/tD0WmawerunmFPvgnQOv1ANvuGtDPhgoTVwOPm4pT6Qr
 wYv/JhZDWSI81TGtgx5vl8cObrMD3lE5dw3G5a+8bRJpFCs5BVbCt1jvsP9WmXuGUVa2awAfrhW
 MvSpVlPe5OPeLvra4MFFS68PGQZmE+HSyVi3Q0qdWmhs+q8/rNlA5c0AfpV40SpC2OZ9n87kWA4
 4925yFXWICkKRMDz1wK07/RlpAxvWkDXt6QU6C3ZnTSTD+
X-Gm-Gg: AZFdTZcEtWWlsU9Q0h26x6QQV5R+k9QGTRHlnZDYc1az2wTdghHXhGjroy4td33du0r
 sFLs9VhlIviwxg6a3ClNZff4uF/JA4Xw/X0tzECWCzGYWutg9BtfqzpYJsCDS5HaHDs5UPsb/g7
 tPvM/Sp+8lg1qEQeEBiZPhu7+7NIX+2jm/aZpEfNZltLRP0XBF/uA8Dw==
X-Received: by 2002:a17:907:6ea9:b0:c2e:856:2a08 with SMTP id
 a640c23a62f3a-c513a3a6598mr1792623266b.1.1795689692522; 
 Thu, 26 Nov 2026 02:41:32 -0800 (PST)
X-Received: by 2002:a17:907:6ea9:b0:c2e:856:2a08 with SMTP id
 a640c23a62f3a-c513a3a6598mr1792622666b.1.1795689692194; Thu, 26 Nov 2026
 02:41:32 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261119054917.184758-2-ltao@redhat.com>
 <85438483-9843-4b14-b3eb-57a074275911@amd.com>
In-Reply-To: <85438483-9843-4b14-b3eb-57a074275911@amd.com>
From: Tao Liu <ltao@redhat.com>
Date: Thu, 26 Nov 2026 23:40:54 +1300
X-Gm-Features: Aa3M54qXSxe4Tv3kJZhv4-GTyuCU96H140dAQ2Bw9YC_NOs4WSOucEjet7OYzYQ
Message-ID: <CAO7dBbV5Baw5SRCNCys21u0NwJ2CCJWu2Av9wzGUHUmMxaE0bQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix pdev lifetime in
 dm_test_conn_init_ctx_alloc()
To: "Chen, Chen-Yu" <Chen-Yu.Chen@amd.com>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com, 
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, alex.hung@amd.com, bhawanpreet.lakha@amd.com, 
 ivan.lipski@amd.com, george.zhang@amd.com, adrian.betschart@cinemaone.ch, 
 rodrigo.vivi@intel.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mBb8ry_cJXYL44Bb5F-53omXPL3PNDn83FJrIiwr9XI_1795689692
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Chen-Yu,

On Wed, Nov 25, 2026 at 11:31=E2=80=AFPM Chen, Chen-Yu <Chen-Yu.Chen@amd.co=
m> wrote:
>
>
> > Fix this by allocating pdev with kzalloc() and freeing it through
> > the device release callback. This ensures pdev's lifetime is managed
> > solely by the kobject.
>
> Hi Tao,
>
> Thanks for the report.
>
> The lifetime problem in dm_test_conn_init_ctx_alloc() is real, but it has
> already been addressed in amd-staging-drm-next by commit 370bab028b38
> ("drm/amd/display: Add more connector KUnit tests"). That commit allocate=
s
> pdev with devm_kzalloc() on the device and registers the unregister actio=
n
> with devm_add_action_or_reset(), so devres releases the i2c adapter befor=
e
> pdev is freed.

Thanks for the info, I didn't notice the issue has already been fixed.

>
> Your patch no longer applies to the current tree for that reason. Could y=
ou
> please rebase it onto the latest amd-staging-drm-next and confirm whether=
 the
> issue still reproduces?

I tested the latest amd-staging-drm-next, the use-after-free issue
doesn't reproduce, so my patch is no longer needed. Thanks again for
your review and comments!

Thanks,
Tao Liu

>
> Thanks,
> Chenyu
>

