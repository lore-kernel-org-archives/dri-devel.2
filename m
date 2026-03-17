Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80B9FCD0D2
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:28:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E803B10E749;
	Wed, 18 Mar 2026 08:28:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MhnIJoMT";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B971510E63E
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 17:54:50 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-3567e2b4159so3296350a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 10:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773770090; x=1774374890; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=B9Xtnzk8DVE/O67gpaznOnmd6kpDI3WBU5cVEoFIiNY=;
 b=MhnIJoMTje0TMp7JYVEvLE2IYXotXxITALfiAQ6bG+8uubHp6fYMrrhzNF28Dds7+p
 cFSDXuz+aQ5GAvHJkWJ/KNQPXGpsrSm4YMG9huwu27WBXbFGnrg5+3cz0AJ6cXxBbJ4u
 NhH9K8CAavZsNvp3x2JAlOLsmfaDLNfoBztgjOPdv+UuugRrmbzgkJE39c31x4M5y6OB
 s7FBqYB52GvWK5nSVhMH4v1JIvWfXZrsAaBZbdEVpBN+5vKw0BJAO86LPzJx6pPNkIay
 2GS7bKdSTEEtwU2qOsTBVrcJpFCIamUSgGdZq/ndnAdzJrDXG94bY+XgBARyEm6qv2AU
 gwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773770090; x=1774374890;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B9Xtnzk8DVE/O67gpaznOnmd6kpDI3WBU5cVEoFIiNY=;
 b=EcOSphk1q7eSeHtZRMPxk/bcyC7RL/jcFZGiPff9FC5xWdn7jyiH3CZsGqQt+0xp/Y
 cmAc9A0xPWFwvF0P4XDuFJ4nHBtcQQQPHYHlW8iq+ZejeknWH4QVkgSqaZupAZ3jE2c/
 yASGzt3L/zP1JiieMG0rTmgZ8+weoyCl5TrUc1YeorJm2xSwpeK3LBkUJ23nmAl1ewq/
 sx09VkEalOkCWidhPLJceH1dWdS5omDDq+E/+DUhOidpX85WiiBC3K9uOaNXM+XbucDn
 Arg32MdkvZC85ocpbZGJ7zsnqCQSq8C8A2X9JVO7gf3OvPDwfTS8XNOx2Xy5piaUrwyG
 D1tA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBRe0gEepZQYUVYc/pXxu2EgboG4q/O6PwLsdxl4vJUof5uWJxloROxGq2q4Ts07H+yIaUmaJeuD8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwEcQeUml1gp69bkiIm7Hqy/x/iSEGl9RKoFEqvcFk5eCOpjvT2
 p7yPdUye6nXVBOLehwrn8FSncyT/TMImsMkF4Fj65W3Dpb/0sw/apiUI
X-Gm-Gg: ATEYQzwJCnjWDLAfbpoyj4VhFzekiJxlO/avHK+AFIBoZDPiCS8EG7E2doLoSLQBvGY
 yuIKD30iVYibTRAUqSpyxsRAOi1ahHDhGC/lQ5l3l8aY3zRDpDot0Gu+cHWcJLYZAYBh+9FFsq2
 j976Tl089dm9P7MAHwuweWpKdmVKYFSUAa2yydCBWJbBm5Av4lGYbHiFAFZf6Gyud4Eo+pdoyxa
 AsYZC7tGP0cRUjmr8VVilNFWfu5dEkjEPI+JQIrNUWcP3x06kHqGz8EYIInXMt/SniCBGphodTT
 uihXMDRY7LC1PtQ0MvGXfhJBYTm84DnSlkRM2uoOFJj3TMSdH2JNytmaxhGBwSVznjD4wwHNJBX
 55VGVIZjrLzBUKI+YX8NeZm83MxtdCeq8p0qFE9tUAFcrWyzKg3IDhQB1bYEkhF/QYZMDj9XPb5
 018F1o47MgWmd47Cxk4wTCuuK93RHkR4Aw3QMui3DuwERQ
X-Received: by 2002:a17:90a:1001:b0:35b:90e7:c453 with SMTP id
 98e67ed59e1d1-35bb9e3b99fmr213317a91.6.1773770090083; 
 Tue, 17 Mar 2026 10:54:50 -0700 (PDT)
Received: from localhost ([2401:4900:88f5:ac25:fbd0:e3bd:86f9:3d41])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35badb90b8esm3559843a91.11.2026.03.17.10.54.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 10:54:48 -0700 (PDT)
Date: Tue, 17 Mar 2026 23:24:45 +0530
From: Kalyani P <kalyanipatra2003@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, 
 simona@ffwll.ch, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, daniel.baluta@nxp.com, simona.toaca@nxp.com,
 d-gole@ti.com, m-chawdhry@ti.com
Subject: Re: [PATCH] dt-bindings: display: convert via,vt8500-fb binding to
 YAML
Message-ID: <jjfjhxnwdom3ejtwxe66k3auuerqcza6rbnidjgav3ee4mhijw@ecvgg2446kct>
References: <20260317172955.250192-2-kalyanipatra2003@gmail.com>
 <f1423235-cbea-47c9-be4f-82b24fb2e590@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <f1423235-cbea-47c9-be4f-82b24fb2e590@kernel.org>
X-Mailman-Approved-At: Wed, 18 Mar 2026 08:28:25 +0000
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

On Tue, Mar 17, 2026 at 06:38:21PM +0100, Krzysztof Kozlowski wrote:
>Please carefully follow GSoC requirements. Really, really carefully.
>
>For example one of the required steps is to run checkpatch. You did not
>fulfill that requirement.
Understood. I'll re-run the checkpatch to confirm no errors and warnings are present.

>
>I have doubts you have hardware or manual, so this should be the driver
>or platform maintainer.
I'll update the maintainers field appropriately and send a revised version. 
Thank you for looking into it. 

Warm Regards, 
Kalyani Patra

