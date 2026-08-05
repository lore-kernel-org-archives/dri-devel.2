Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81116C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 20:55:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C81A410EFCB;
	Wed,  5 Aug 2026 20:55:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lILzDJIh";
	dkim-atps=neutral
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2599510EFCB
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 20:55:17 +0000 (UTC)
Received: by mail-qt1-f180.google.com with SMTP id
 d75a77b69052e-52b6543169fso9402751cf.2
 for <dri-devel@lists.freedesktop.org>; Wed, 05 Aug 2026 13:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785963316; x=1786568116;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dQeleUHR/VN3i/9olm3Eb+prEK3JwfisQyJRXtHvIlY=;
 b=lILzDJIhyFb8bNx9+yb6K1vbAXXVEelaRvHW2G4C4Y3de/TX3XT7llLRUl0WVMLHRt
 q4wR13NwUdfZ95F8ejIoUZSX96lCGYvqf/6fqWInO4jN9tzvTV1dvFJb8PG5G+DzYW66
 ldmQstaiyxKq9kb4+m7HPdp9T3B12ZsDbxo+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785963316; x=1786568116;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dQeleUHR/VN3i/9olm3Eb+prEK3JwfisQyJRXtHvIlY=;
 b=lCvlYO79PbspiATH1ET4EfzaGElha6myoTQNW5vZGVnhmm22TuzX4Drii6AcCa21Iv
 GIQvCEtYHqD22JCzPQLEmUWG3FpBhmEIjyxw5yCuHy3ccLIU1OlP1Jtn7yrjt8otHoMr
 6Hr6itsUSol74UTeQEr6NmyMuIaswT9DxEt7AEkoVIl23KpF8BMPg6kWIANleDSQMZoV
 c0Mlj4oH0SBnadXYx+pNG0htlVb2x5UAjJ9KxRE7LA8HlDN0owSdNlpc2KCA2/rP2UD3
 YIP6LKFYexR7fT3ty/OJjH4QLecQFWbdocYZ+Ne4MrU/rzhJcKUw0o4hUQj3CnfvJ16k
 Y/ug==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr92ypAUWaMVE9I5hSfLfmxA80aY2cvO3on9yIna0NSlaxxUlmEKXw85GbY8PghhkRn8DnnCLwSpgQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwT1O1OMtoOYAe1YXh23dViPJ6MNDHZERXCBZm6zDfGB/vhirWr
 /BUvh7xLAoxjgorWxObLX33vH/rGTbHwyC3kGfKpJizRcv8z8wS5yI2hlPJMfVrvysTmBy1x0ua
 T0wM=
X-Gm-Gg: AR+sD120m9S71luP3XqRppDqWbAOGecH5kAvcEsMHFz0tg3RvyhP8+oNkNNKcK3Gz3l
 PZ21lrh8m555UePEaJxsj8NPRL0jClvrKfWWJnv9ChzFvwJ/W18UTO6wt921dmR1YinsGp7zxk6
 OUUqMjsVkDFKx7uXkz9OgWKyut1rOk6ZS4Bos1o4nWMYPKuF5nQpfc/ScUGYHsAUdevNoTtciaj
 lhLTIYiFYoWansWe70WV54udztaDXc8L0S9GomC2rxB7Jr7Trk8rNppXslhFTKW5guY9totMdRy
 ZyeddOSbj9ChXq/CcfNhN5Zl3JriiTJCC5qf4PyJABsSwuTa/zqRuM3+1rm+O0hTuNg3tzLN7hB
 1FZqXg6XH6+OvxjWSelQKu50oeevr/BHqa2UV2jSiUrnKdCTvAcY76qtMXGULWVwwd0lXStLAHk
 iQeKPqqED2rzV3yTGYfBAHZ1n4mEzRYLUaJyI1tsf/SroYOTE4B9VQ5/BQpcKe3Plv9ryu/CQe3
 958xmLcwKkH8Ui5Y63bH4t3g38=
X-Received: by 2002:ac8:58ce:0:b0:528:583:a6c6 with SMTP id
 d75a77b69052e-52ce5f26afemr85354691cf.6.1785963315896; 
 Wed, 05 Aug 2026 13:55:15 -0700 (PDT)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com.
 [209.85.219.42]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9088008e6basm34447326d6.26.2026.08.05.13.55.13
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2026 13:55:13 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-8eeadbc5e21so9975046d6.3
 for <dri-devel@lists.freedesktop.org>; Wed, 05 Aug 2026 13:55:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RpMqgkchpTXRR6HCAjwPzgb+1xu5nW9S7KsWOcb43ezCqeCrdNO99DDSH0qPe240DDMkfOcOtYTjBg=@lists.freedesktop.org
X-Received: by 2002:a05:6214:2aaa:b0:907:5451:8954 with SMTP id
 6a1803df08f44-9088125ac58mr97922226d6.16.1785963312611; Wed, 05 Aug 2026
 13:55:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260803-edp-v1-1-3e92dec1d56c@chromium.org>
 <CAD=FV=XeW806uSg5JM95qHrfKUKXpC_z9BUaDv61wu0KGFry5A@mail.gmail.com>
 <CAHc4DNLeDaa5gXjiJtmH_0gyCLVk+=MhziL60Uy4eh6-u9QWew@mail.gmail.com>
In-Reply-To: <CAHc4DNLeDaa5gXjiJtmH_0gyCLVk+=MhziL60Uy4eh6-u9QWew@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 5 Aug 2026 13:55:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UHk0Q=4L8zQoaV4jNMv4ajUKH=8L=_C_KXwTxrgZ=bUw@mail.gmail.com>
X-Gm-Features: AUfX_mzNHn3W0ag-OLAHaolyh6b6gBuxd2Ej5DSZwivUn_40Ge4Rg4cMPGBWXi4
Message-ID: <CAD=FV=UHk0Q=4L8zQoaV4jNMv4ajUKH=8L=_C_KXwTxrgZ=bUw@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add pre_unprepare delay
To: Hsin-Te Yuan <yuanhsinte@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Hi,

On Wed, Aug 5, 2026 at 4:11=E2=80=AFAM Hsin-Te Yuan <yuanhsinte@chromium.or=
g> wrote:
>
> > Looks OK to me. Thank you for the thorough description.
> >
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> >
> > Do you happen to know if any of the other TMA panels should also get
> > this updated timing?
> >
> No, this is the only one the ODM reported so far.
> >
> > My thought would be to land this in drm-misc-next instead of
> > drm-misc-fixes. Is that OK w/ you? I assume you just need a stable git
> > hash to pick and it's not urgent for you to get this in through stable
> > trees. Getting the updated timings is usually not massively
> > time-critical and having bake time / avoiding merge conflicts is
> > nice...
> Yes, I'm fine with that. Actually the original commit is still in drm-mis=
c-next,
> so I guess this can't be landed in drm-misc-fixes.
> >
> > Assuming nothing else comes up, I'll try to land in the next few days.
> > Usually I don't delay at all for panel timings, but since this changes
> > an old panel I'll at least give it an extra day or two...

Pushed to drm-misc-next:

[1/1] drm/panel-edp: Add pre_unprepare delay
      commit: c8d3d795dd40c7fb35b39ebcb99ae5f2f1884b48
