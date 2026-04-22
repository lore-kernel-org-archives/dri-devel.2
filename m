Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2AB7F9EDEC
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 15:05:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DBA810E2B7;
	Wed, 22 Apr 2026 15:05:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="R3W6Z4rK";
	dkim-atps=neutral
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC9ED10E2B7
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 15:05:48 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-ba7fd666666so394580366b.3
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 08:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1776870347; x=1777475147; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gA7eKH7J3A5zn7bbRs00GNHS2AH6hwEh/iROnwC+XDA=;
 b=R3W6Z4rKpxks3Kdi2wujiTS0kAQdmfbgpsC735S6o1U9mkTFrtK8U2Ovas/39m7H3c
 yeWhPaHfuVpuSRr9odLrlWPyWokBe4ELzD3qYCVOv2r7oD1vWnYRBMwl/DSZ1qmTGXi8
 T5soeyX2EjiIqUKaJ46JXAa6NOgiQkKZdHzFPmr6uzFsfEfRJMM75SFoTdjp3ZBFYY8E
 KzTchr2T5ucZiLKepevV/b8asZ4WIy0BYlvCbfor1Qj1EWw5eT5BCGc/EVS4sa0a1LQ6
 Uy5lGTm7nmnbUsHiw8VsY8C0Cgr+T2t90IolTgQe1+Tvxfw0zrselfwtIn+HcKM9d5h4
 vplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776870347; x=1777475147;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gA7eKH7J3A5zn7bbRs00GNHS2AH6hwEh/iROnwC+XDA=;
 b=NX3BFzSBBhdTAIj3TR5EADeLiPKha/Ry96+G4IiqSp1Zyxe/ymovO8NK9JEHQoMQ+n
 00ldPPX9X2drgWQ+cw4ihRmJGg4laMgUKYJcHN6kA3oa9LQ2HG/DQ8fzDct5ywqzeQTE
 UWLTxDrEUeyccHmOZhi0PYO6hJ1tgmL8ts3cnSZCG/veM83UoJRrvxP+R9rUB4n9gxAI
 HKG+TB7cmbDr6K00MbhJsSBSd/vow95YE3g79IQnruyQb+62QFIv6wgb8f9T6p97YmqP
 Ri5Xnob9DYRJB9O/V6KiOFaZtNU9SKkl15MhZLWmbmsJmX+pkBq5EiNFdfd6ovoBiRW0
 i3zw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/jd6G0g7+cePt2/ZaVqnSu4hKyXHOGA4dO0wGDBhAIJPolG4IlO3Ri+6UhevrLZU9Z04hFsp+Vfzw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyFJilN+63jEMiDTs/FoujraPrLguYnMJgy9YI7texHDBY0ae0h
 EDzvlYF2y+xbJFo2TXIub3oauhADxGxBPqTTn9U4YUTkJEk6eLq10I4+tcTuql4zi6A=
X-Gm-Gg: AeBDieskSsF5W/K6DBY5Jp7jp6QqYUvQ3lIUNvpk1LyqG40zNRqPkS/zclLPApat1qC
 p7dtUQ4KebMVzpd2Z91t5r7zoRenk9eu+QNWRpl87+ETVwaD9s9gEOCgxI+OD5DHX3cNYWQFKFm
 KxfRjCH2ldzVzAZQWn3koFjGPKROxLXd9t2ZgGPEuEa9xetkLzbJoCDEFn1ihxROIUi+9TQBUl5
 19SgErcK0WzAxW9DkCpidhADxWDDAPcFJ+++xnxsfeDxMthzOhUpKYHtMTPo/RJnh/k7fiPapXc
 AOoVHlvE45CKfuqySbM/Plq9UiBIhWxe9iwZoIe++ekaCZSDen9oM5VTw1w0h2tYLJBvo6z4ygd
 Bwlo7bU+2LAhPvRCIKS0/dTsjzNjGZaq9KQWBYvKohNvRC0xtixIAe8ufwolCc8IVTQnoZY8gyJ
 BkFvUvZV6eWnufaJhvXcyGkkmI3fQR2OYEfDhZT3vHTONyWTEkrKOMG7o=
X-Received: by 2002:a17:907:1b1a:b0:bab:f5f6:d700 with SMTP id
 a640c23a62f3a-babf5f6d819mr14085266b.38.1776870346790; 
 Wed, 22 Apr 2026 08:05:46 -0700 (PDT)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ba454d1bd24sm548447866b.32.2026.04.22.08.05.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 08:05:46 -0700 (PDT)
Message-ID: <eabe4e7e-00b4-443a-930c-d838a9aa96e2@ursulin.net>
Date: Wed, 22 Apr 2026 16:05:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] DRM Equivalent for top
To: "Francis, David" <David.Francis@amd.com>,
 list DRI developers Maling <dri-devel@lists.freedesktop.org>
Cc: Simona Vetter <simona@ffwll.ch>, Dave Airlie <airlied@gmail.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "lucas.demarchi@intel.com" <lucas.demarchi@intel.com>
References: <SA1PR12MB8144E70E3AEE6CF0F54DB090EF2D2@SA1PR12MB8144.namprd12.prod.outlook.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <SA1PR12MB8144E70E3AEE6CF0F54DB090EF2D2@SA1PR12MB8144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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


On 22/04/2026 15:40, Francis, David wrote:
> AMD have had some client requests for an equivalent of top that works with our drm driver
> 
> We're looking for an interface that
> - Can be used by processes with no particular privileges.
> - Gives a list of which processes are using a drm device (by pid).
> - Can give (driver-specific) information about these processes.
> 
> We'd like to do this in drm, but drm doesn't track the pids of processes that have drm
> device files open. It only knows which pid opened the file and which pid last touched it.
> For example, if an X server opens a drm device file, creates some buffers, and then hands
> that file to a child process, drm might still associate it with the X server.

Slight correction here - DRM tracks the last ioctl already (so last 
user) since 1c7a387ffef8 ("drm: Update file owner during use").

> We would like to do this through fdinfo, which does track by pid, but that would require
> making part of fdinfo public, and we received negative responses to that.
> https://lkml.org/lkml/2026/3/16/1816

Would setcap CAP_PERFMON on the executable be good enough?

Regards,

Tvrtko

> Would the public-fdinfo idea be useful to anyone else? More support might help push it
> to acceptance. Alternately, is there appetite for an alternate interface that could
> provide what we need?
> 
> Thanks,
> David Francis

