Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE4D8CA5FC1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 19:42:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B58710E154;
	Wed, 30 Sep 2026 19:42:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C0v8kbGa";
	dkim-atps=neutral
Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com
 [74.125.228.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5146C10E154
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 19:42:33 +0000 (UTC)
Received: by mail-ej2-f43.google.com with SMTP id
 a640c23a62f3a-c2a8b9acbc6so886983766b.0
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 12:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790797352; x=1791402152;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Mtiohi+MWIdfMvXbDsV6odKf5ibvIBEkB5eaedtlMyU=;
 b=C0v8kbGaJ4ceG6/0Z6K94/wNQLtxGncKldMA4GerPB5nzyrC4SOvxVt2m+vu4RpE3I
 OfmxmebP4wBhc90YyNeDEwKtiV5mWxMBatKjtD/DEWTnAE+JFvtVLRjuAWi7qgTtw7Jv
 EdVIJ3OUzv/ivbtxrtyBFYjHLDbgCwtbH4LIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790797352; x=1791402152;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Mtiohi+MWIdfMvXbDsV6odKf5ibvIBEkB5eaedtlMyU=;
 b=WqqvP+F1V3eUdubtu9YhqUki/oOd6xjwXjorN0e83D3sHnrxx6RkXKjRvptX+UVxoi
 Rogz/RuQwFCEyYH3gp1rFQ01/HpaXNtj2m8P5RJZYkpVwRz2YvT3Aa/XGYz9s/H15BRz
 kZqBVTdQqpcuQhacuLIM7x6oTC4scyzfTS6yhxZgWHaHqoHCPf+NFTmS8DDfrSLPSZX8
 5E0ClU4uOWNzi4XzsQFCGAv5Gi8KbIeOe+3o3ehRXW725EA4WIODU2kvdaXf0YQNBhM4
 wL2CNDhHuLzWdENxcyr5xjQkmBvKpVuMub4M5JZgLB8tY8AxT4zs/sFwCLcygSSae7EH
 gKGg==
X-Forwarded-Encrypted: i=1;
 AKwUvBybUR2lRTlkvZNF/+EiKygFGmPLu++1JHm5sRAwih1TorSokxswusfflD6U7VRZF4zv0a02FTqV2tE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kqOzI15IijDFB1CBaKmhyFR8q1xnN/Gfb5477866n9q+osJvvM
 MlIHBiulZDJOfPlWWiGivLEfxCTZ71h+htMJZI3H5dyCIsOBkHyM7fbnoolZDIkCih/MF4+MRxi
 iKOjGfA==
X-Gm-Gg: AYBFou3KPGuf4Z9p7cMHQ7/TmZg1ZAupROrEJ9ZHEMjRI2ZOLUpmzgeBVXPSqHZ8F16
 FDG7cDCgr8AZbxyGWPznPGAx+1Kl8j6Ckx9DzS4ej9tGA5Moo4c0fC5n99xMpYABXtqT3PUJ4RF
 ThFfo9gN+NGG7CnJ/PZMOcfOd0r5G0cUsuvUKhfBrNTzhoR46yIvEUNR0O+SU/JFTs3rL/r+w/y
 NXe9GvF5MZ61C6SEHgibbp64pfOdPVrlFTdlzaz7BBQQTmkEB+kBf1gR+FUdhqa8JZHMN88R7K5
 Sbfa2QuGssgcN37/7lEMX0FNeb40GQ8aTGGWqAfbIFcnnmXRP6hGTobv0mzlpmvM+YKR9pfr/TM
 RhDhiEss8O3KuLh9PKSRi0eO6U/f221g8lItF4uwTvmV58qbxgm2WLVPBHa3Qb1v+6ErFA0jU7H
 Nj/9OZih9w8gyc5tj4JtLO8kmH7luMHRssxc/fBkTrS49CjRHRdLvVQcf1ihhXJ5ncOGLrmPi+y
 IVKWWw2uaC51EuCSAI2mn5UGMx3hiJifDcs42I=
X-Received: by 2002:a17:906:c155:b0:c2d:d1d8:b220 with SMTP id
 a640c23a62f3a-c2e23e0edf8mr215047766b.42.1790797351589; 
 Wed, 30 Sep 2026 12:42:31 -0700 (PDT)
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com.
 [74.125.225.140]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2e31dc70a2sm50238166b.64.2026.09.30.12.42.30
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 12:42:30 -0700 (PDT)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ffbd83a92so36730845e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 12:42:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBy7ABiI9ZdqtcODQhpYCS0LVBQOtVxXtZ/hTiNqGviYuIc4twSO6HmA5yhY2npksHKhotGM3lAD6Tw=@lists.freedesktop.org
X-Received: by 2002:a05:600c:4f4b:b0:4a0:35c:8953 with SMTP id
 5b1f17b1804b1-4a01afe8499mr48313695e9.7.1790797349053; Wed, 30 Sep 2026
 12:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260930063856.183763-1-zhouhaikun5@huaqin.corp-partner.google.com>
In-Reply-To: <20260930063856.183763-1-zhouhaikun5@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 30 Sep 2026 12:42:17 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VjKzh636bu4yNQFsGKj7bLZB4oWr6X=So58VHSp=UhAg@mail.gmail.com>
X-Gm-Features: AclHuK8kkfbOUDtVvVwL4GpB8KVrlF-z76CfF7jLe5vynXwJYITtPiQlL47fZUk
Message-ID: <CAD=FV=VjKzh636bu4yNQFsGKj7bLZB4oWr6X=So58VHSp=UhAg@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Support NV140WU2-M70 edp panel
To: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
Cc: neil.armstrong@linaro.org, sam@ravnborg.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 daniel@ffwll.ch, airlied@gmail.com
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

On Tue, Sep 29, 2026 at 11:42=E2=80=AFPM Haikun Zhou
<zhouhaikun5@huaqin.corp-partner.google.com> wrote:
>
> NV140WU2-M70 raw edid:
> 00 ff ff ff ff ff ff 00 09 e5 ae 38 00 00 00 00
> 14 24 01 04 a5 1e 13 78 07 7a 95 97 5d 59 95 29
> 20 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 24 31 80 a0 70 b0 3c 40 30 20
> 36 00 2d bc 10 00 00 1a 00 00 00 fd 00 28 3c 4c
> 4c 10 01 0a 20 20 20 20 20 20 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc
> 00 4e 56 31 34 30 57 55 32 2d 4d 37 30 0a 01 35
>
> 70 20 79 02 00 20 00 0c 9a 0e 00 ae 38 00 00 00
> 00 14 1a 00 21 01 1d c8 0b 5d 07 80 07 b0 04 88
> 74 b9 5d 99 85 95 97 42 20 02 35 54 b0 5c b0 5c
> 66 32 12 78 22 00 14 3f 66 02 85 7f 07 9f 00 2f
> 00 1f 00 af 04 3b 00 02 00 05 00 81 00 15 74 1a
> 00 00 03 01 28 3c 00 00 53 42 53 42 3c 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 8d 90
>
> Signed-off-by: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)

Pushed to drm-misc-next:

[1/1] drm/panel-edp: Support NV140WU2-M70 edp panel
      commit: 37b346eab23aead52d17a8fa687056bfc651a416
