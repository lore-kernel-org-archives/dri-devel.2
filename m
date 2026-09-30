Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE53CA5FC1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 20:12:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1057710E320;
	Wed, 30 Sep 2026 20:12:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SOIb5aBW";
	dkim-atps=neutral
Received: from mail-ej2-f41.google.com (mail-ej2-f41.google.com
 [74.125.228.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A88010E320
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 20:12:56 +0000 (UTC)
Received: by mail-ej2-f41.google.com with SMTP id
 a640c23a62f3a-c2e1195040aso235421866b.2
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 13:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790799175; x=1791403975;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7U6thcsc8Wz1xK8U5Qhc7QgqtaRZtBZlNvbNYRYr/EA=;
 b=SOIb5aBWTsIviTE2mUBImL1mqTuy5Z9mzDjoOV2PPnDV82BjZzNH4CWchLMHu/xg2u
 9ZzDaFrqHhZOaWJcwszF3Re+fpATVe/kgyBpdAUxZM5EtdnaaNrNsaU2TqI6VDXMsXN6
 VRdxL1MuMtvNkTaZy9Q4mAsc6JonMgUd74h0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790799175; x=1791403975;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7U6thcsc8Wz1xK8U5Qhc7QgqtaRZtBZlNvbNYRYr/EA=;
 b=bwMzCTYQDmAp4j1CxQWi3lYW7W2E/z609d+5d9qQwwNobGyzo6CBRgQDoSGhGIekaM
 qAS7j+W9ebBPhIdQ4rhdraIKhD2lvET0o/FyXyo84VwW6IKcddt/zSH4duSNWAzzy9e/
 dxW3vL+Mk7iNOipcIU+SRG4g67z3kMnQVsWF9vm9HY1PO+7SYXLWfGmfp+3vIJs0TqdR
 mxgt0h22cXNA9H8ufuU9ot0e3f5opF9QrnAQlv3EUIIyBpZlQV+1WMotFawb0T0Sd2BF
 tU8O8Z/D6I1qBkA8/ukTSw5bFOaBbP6YykVbKB434CeWd8dhhNhcRzRSgeFD7Z2Lisfb
 3ftw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzb6ZMhRiiEQMSNOmqOxJjkdPvHLqQYvAJJLxv5lbhribYBfKMfaBNrpKNF/9ehzlFWDV4QiloAGVg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kvA8UJ37PFxyHXi7xv6g1qKN3K/yVB/f5Oi7dHYt42JQo6zm2+
 kfbzNPXr5TkxFaw/hcDNqoPixXZYo+gjhnDZXWYiNZYsA0INRLGlBodsh5vs+vZVPmzCCZ23a1Y
 9nFJUGA==
X-Gm-Gg: AYBFou0zwJlMzJ1SIUgw/2opcFTJum1Qa02M4aZqJJJchCu4GF0GHssDYqL4T/zidMT
 OScUqMzQM66r0QoO9G+2tc3KAopHzE9tbN2VMxgwucXV4Erl+rh08ye6bAxgZMeLhMTOjburrHC
 G8KLjrKA2lS8/fp/3bRQibaU3xxVgjQ7oHdmn6J0ANmhtgxWQZ92m9pFEhjkGG1smjQEFkpsiXb
 kWREq5sCO+N1MtW11+rHjmTP9ZpJ/tFneb4gBIPeqG5ZqOnT1PUwftT+Hfea584I6wcQdqfPwaM
 TWZ08FpFroWF374No0zGMAP/W9VSpyIKVDHDGq66OyNj+3z+jEaJ2JZ3843Bb/WnwGT7AQJi07g
 72epNlbgDyBw3yZU3xSzwgxmSsUDj5+z8a1gbDixI0mCmcjKffbZVcYwlX3bafPS8t3ClycwFMP
 hMbUjgGhg31aig8tjNL7YDyee0GOaxAdJZxaJH/5sh3WNNuiRRSyes2BxX5CiccGb141CFQeLxT
 CvZ5GIb4k3iliehG02H11O5mj0N2LAF0F3trQ==
X-Received: by 2002:a17:907:d1e:b0:c29:cf4b:5cac with SMTP id
 a640c23a62f3a-c2e23749268mr217469766b.5.1790799174818; 
 Wed, 30 Sep 2026 13:12:54 -0700 (PDT)
Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com.
 [74.125.225.98]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ae5ca42180sm91439a12.10.2026.09.30.13.12.52
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 13:12:54 -0700 (PDT)
Received: by mail-wr2-f34.google.com with SMTP id
 ffacd0b85a97d-48b01c41135so765730f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 13:12:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBz8rqmBbjTpWaT4+RE2uPaJvpj0uzPwi4JSQA0FXVzPNUbF1gi4yA7kukrsDgpOSivkzi3N3CRzgaM=@lists.freedesktop.org
X-Received: by 2002:a05:6000:2301:b0:488:89ed:4430 with SMTP id
 ffacd0b85a97d-48b02522f7bmr5017118f8f.33.1790799171532; Wed, 30 Sep 2026
 13:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAD=FV=UohyFHM3r4i6NoDbzVFpY9xZzg_=FvGFhBgScaCUwH2w@mail.gmail.com>
 <179045227485.41069.12855843493298872118@gmail.com>
In-Reply-To: <179045227485.41069.12855843493298872118@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 30 Sep 2026 13:12:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UXUmdt6MMdpmc8+Ef3K_BDA_=HBrm=55L6rN3CGFXrXQ@mail.gmail.com>
X-Gm-Features: AclHuK8FcTnHffXPC8rDzSxRGLknuirXL0tZK5LTHVWoYw6G_lhLZa_jZ9uuWUA
Message-ID: <CAD=FV=UXUmdt6MMdpmc8+Ef3K_BDA_=HBrm=55L6rN3CGFXrXQ@mail.gmail.com>
Subject: Re: [PATCH] drm/dp: don't mark the AUX backlight enabled when
 enabling failed
To: Oleg Keri <okerixx@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
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

On Sat, Sep 26, 2026 at 12:52=E2=80=AFPM Oleg Keri <okerixx@gmail.com> wrot=
e:
>
> Hi Doug,
>
> Sorry for the muddy commit message. Unfortunately i cannot reproduce
> the enable fail. I found the unchecked return while debugging eDP issues
> on glymur. Please drop the second paragraph when applying, or drop the
> patch if a code-inspection fix without a reproducer isn't worth taking.

OK, I pushed it to drm-misc-fixes while dropping the second paragraph:

[1/1] drm/dp: don't mark the AUX backlight enabled when enabling failed
      commit: 707ce102521496c67860d81221b20c56d8255f2f
