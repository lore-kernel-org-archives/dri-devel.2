Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D42CDB479
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 11:00:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D1BC10E109;
	Thu, 25 Jun 2026 11:00:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RVx48wg2";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E08010E109
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 11:00:29 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-46e30429b10so177009f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 04:00:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782385228; cv=none;
 d=google.com; s=arc-20260327;
 b=LFe8HAtgD50JCco483TGCq2a+57r8mk+x7DyTUL00xhQmTscgfZ1CTmlKNY3tw+GkO
 9NPb2JNNRmkxuACYqXcnRUWhwdex4/IvHJ4JaAhL9+hgwHEFhBJrOUX957TxJr/uCN9o
 iP1FkcuLE89J89CCwdh5sh7m4ZqJbATJrP+NWLx53Q1Tq0nLUY/rA4XWihdjskmiJ+lL
 asvvhWq2fqLkwJKP3Fhb0Syb+oZzdcrlfFJ/qpoyHlIGbO9kVOFscMylUf7RHhiEBmsp
 5M3AVWlrP34Nq3Ok0g/y3F2tavm4Ahj4C/eDtM3f7OL4PCQyE0nwDiIxTZKt/fNQIz7L
 jNsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SYJ9K/irCjAHZhFgkU4tEC3o9IbVrQ1kbJDsUWJW4tg=;
 fh=tjbNSYmX2/9iAljWr6J//maPQ3wriLBqLRNGWG1QMxc=;
 b=p/I6m2WbWRTiuPfviDeHMWW7oW0CKul1NkbFo6qWWeRyq9j29UnoTlVm6pul9IGsk7
 OrUFWtYhL+Ffhw2FosyNtQKjcChvBhT7Ga8DYiqLGhuA62GnfX+98Y2J9X5x0pNiovdv
 4xhXUBzQtahBeAKS5NVCH90SiVzE2o5RPfHTjXHqeeWnJ+2yPDjdl9693ztUKZhYE0lA
 F/7b/1laONsdRFTJdrTS53ZGBQ1H50NS1jRdSlX8vr2I4HCNte45XVMnrWULZ9DN6PH9
 djwWo10gnb11D9S9yWTEpAe6RZJR3/0JezBLO2Jx+bGv/oyZdtAq/nCqyqyceF6tAOR/
 u/tg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782385228; x=1782990028; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SYJ9K/irCjAHZhFgkU4tEC3o9IbVrQ1kbJDsUWJW4tg=;
 b=RVx48wg2CRlAt2vHkWcWHnrDX63x98TLxSUHTJakoDYvq2qSxe+ePYe/GwUc7a1Ez8
 nS+oYxaeotuJWEeVvNN5hAbsVm8YJlz6iKjSw3CBn42wZX2KvsYyHEU44vqP95817Wa3
 dgAZODUj/gaxSt1St4UJ05iPDYosNUTNEtN5RIYpG01Nfu4s4HFwHd4iytB5BzkaVOzh
 45wdiWe3ODdu7z+i+3XIRZ6bBwYZ1QydXS3EhEZSTOWHR+l65ZYXQvLSR0I5pUHiEyki
 VHdzzVI4P9nigE8/O2p5XBOWwvJKofN4Susalr9h/6HbN+4CnNdBr8+8d/wofab0+zWa
 tYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782385228; x=1782990028;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SYJ9K/irCjAHZhFgkU4tEC3o9IbVrQ1kbJDsUWJW4tg=;
 b=fl/mbFxdYvcsZSaeiocs0u9elP7Q9eJPTmYPIK4hDWuWlPXutD8KyNr7mFFBtB19yX
 ZpcdR962cH78jFR5WTF+EbGF5ONQFIYgxtqgpCWGwo1hrd3Yb0LYFoMaFQKYMwzrr6c6
 pWvl+Ny0/VDqOZ0WfvOmdwvewQBXpInsCtGOx1Rn7RgUOlFB8tabp5t8E+teGMzWevgk
 a7vl65/xBhgQ3bZUk7tblme2a+Ldm/++w+/e0YYnRtWnuuAJsnuS29Czm+LgggRZiHGp
 XniMcwEjjTQWkyFINVCFnkvPoYBZiXCkajSZ09GfpEv0kM7wDjL3Ab4cWZPvv8c+i5lh
 5zsA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoADKx8ylsMo2d4VqCWDrG80qRzFcwi2v/aN5bKhp/N0lPgVNhP9Vhq3Uwf21ZZAxpozniHUzsgJgU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxrM97LaiJUXDqdlXFHGucAXLkAb4aZErxXdTir2ciAy+GoCQ07
 VO5hBrRGZ/bjl7F1cEDlbhoihGSnTuJ1PPkXOUWFki8eulfdyvfL5vm58SNgma7hk1LtROgS8TN
 f+ihTsa86Pd+JwOyDkXc+9cdZgXetTSk=
X-Gm-Gg: AfdE7cmrczlL960xUxG8lnGLd82z8aoZjOuPxNEwB9/Nga3jJC1wdgCWqtjtPUUhWJN
 IhuXNxTc68Aj2s8L721oEPZ2/BEt7r5N4z9MyddeKNtgFxtjMYK4WQqMaeKeqftWmxw48LBkPXo
 28yvPtx0PopbE9LjXQAfq9M5irV9UxL5TpCPyxJf7XYnu7lrTCnjqcWS8mjRc0uW2gLeWZEghYR
 q4aW9pclBXBf4BHHLPy4gSQkjuF4uXLPkhsfa56f2/psBqk91j+HckpFqJ6QhZmWgb0fVZI
X-Received: by 2002:a05:6000:98b:b0:46e:1bcd:6a0f with SMTP id
 ffacd0b85a97d-46e1bcd6be1mr1709213f8f.10.1782385227477; Thu, 25 Jun 2026
 04:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260521133537.3438468-1-maoyixie.tju@gmail.com>
In-Reply-To: <20260521133537.3438468-1-maoyixie.tju@gmail.com>
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Thu, 25 Jun 2026 19:00:14 +0800
X-Gm-Features: AVVi8CdjQVfdmvFjsaSWCi4UnNz1OBoLuP5LUHLjBHGhcG0i8c0m07TuDEVi3ZA
Message-ID: <CAHPEe=GiP6GKaFWrd1M2Oc2Dod5PECD0nCwX1OfdP88nQM+z2Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove dead empty checks in ring_mux
 ib_mark_offset and end_ib
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

Ping. Christian acked the approach in the inquiry thread, could this be applied?

https://lore.kernel.org/amd-gfx/ecab2606-e54b-4d21-93f0-0feaade64e6c@amd.com/

Best,
Maoyi
