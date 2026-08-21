Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B43C5DF88
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 03:51:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 345C810E619;
	Fri, 21 Aug 2026 03:51:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="enFhJKfX";
	dkim-atps=neutral
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D10210E619
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 03:51:07 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-6a422090b14so914902a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 20:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1787284266; x=1787889066;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=f2GYSCwkuP4SKTO+kMUObbL8oCnO5Szbm9F7xR8yMhY=;
 b=enFhJKfXITjn4hnNlYnd1fewNdi1YtSP4OkHqqgGurVIc13XGQ2J99BVzB7jCNy+r5
 eo9thaDPv90vfxCkduOtKnr0a0fQa2OKYyOHRuIleuUNzSdBESZBbLh+6xpYwxdta/lu
 bv9u9xnZ3W9VkupP4YKqWtDERLAkC7KHrDDA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787284266; x=1787889066;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=f2GYSCwkuP4SKTO+kMUObbL8oCnO5Szbm9F7xR8yMhY=;
 b=fhHTG0WsEz3HXWf7wNsLjVaT5qCk+GmeMkFoZ400u3oLVxuC+ZCrGou+FFVjin6MmU
 fH5c6prJ8nqa9XPxB4NkvvblPHNZ/JxCFobl1yzN5yZZN1EfHhL4YsOwQzpsfFQ9VI07
 tKLRuGZd4Ig4SqrvDG7KiqLfLrV8ketpCWKdqEEJEQVRpkOBTNPwV1G4TjlIMnYmdg7H
 V6zqX9Hyyoj/7LBcba/mFLHawn+HLQxCP8fwgx3HkLlenvIrLSqlLPGbeZ2F4mHNi9Vj
 znXBbXDYLW2qd6qVPecPwj3Ztm5o6z03+8UUoT0U+/vUwGSJF5cepEOhal5jVAAg9t52
 NIEA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqtC8AXcyAJNnYYAhjYV+iCHH9dXPjJH78ylnfNaAUgM/oidPcpToxWTpkBjDXIkXYxV/5+0hdQEk8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mTz22POSAr+5BbJj8I0H8G0EmE26OL1W8oTToHnq67fx6kWZeP
 vPAPUAA34SJrujhmGlB4gAUM38C1wUNI9y3a+aZRvP8cfXNctlAJITDIQokTcudFVqGsV51vjFv
 F8sLfqyZLZA==
X-Gm-Gg: AR+sD10AzUv4jBg0zkI/DKpUQebh/vbGFoJxlufozU8z+bSgqb3cs/AH3UVyUcS7seY
 qfmE2jtgB3n30fkI5HrdcKzhGcS/QhxQcF477zwmQmbVXEZgUlUzEuKZ9Wb2T0NuxB1r9IN/cmv
 YPlDfhDf3fnoR2j+acbTVHbSBpSL05RZRjtXDBxEw701fOIITOfAisVPLM5phX1Rko5mpethUlc
 QcTdoAvP4zcdnK2Bz4y+kHOeayoPdFhZf21mU8wvQ50ddVR74Ctt+a4HMnzrQHNNjlJjyv6r5we
 gqzzcidb1/W0XiS7RqRXMZ+NXrFOpre/6v/Rm4yyGi/p0+KWJfe9S9uhPJmtE59ls00uoaJegLl
 y5NLN+zBFW1AHNtt5WFhnyIXJocY3yN6e0pDYybbswuwa1k8dBqmZUaIIE4n3+nQxOoYjlnwG2Y
 svXmlK6nZEjCtDxrKbpVGqgjPtU6X9+JIRRAOVuxC+FDzqFjGghqP79cyuJhGJ5MT79QgTOAH19
 +qR7xTLOFBQ9he8Lb0liGkKBLN6ApJJX/xZVCocDzCxnUXR
X-Received: by 2002:a05:6402:5d2:b0:6a3:87b7:b516 with SMTP id
 4fb4d7f45d1cf-6a42f18de29mr4128620a12.6.1787284265562; 
 Thu, 20 Aug 2026 20:51:05 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com.
 [209.85.218.42]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3ff177b1esm4304710a12.29.2026.08.20.20.51.01
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 20:51:03 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-c1671ec8692so84260966b.0
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 20:51:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RqzSMjnv2trZm1ps/QYITRL4BZLeb9baDoJRqV58N91eQ6RcHOfeRavDAQ8xurK00cDiQjjJ5Fleho=@lists.freedesktop.org
X-Received: by 2002:a17:907:d64a:b0:c1c:4e36:eec6 with SMTP id
 a640c23a62f3a-c246a728577mr322970066b.18.1787284261126; Thu, 20 Aug 2026
 20:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whiv=b+dAvjaZDsZkfUEzjZMSSLExDOWVcbJ0exsCj6_Q@mail.gmail.com>
 <6874536d-ab1a-4dd7-a23f-2a071bda145e@lankhorst.se>
 <CAHk-=wj5aE1yVMb8RM2AuNUHSMnQDaGT+Vy+At5ds1vxBA+Kng@mail.gmail.com>
 <ahDAErDSE-SFA0oM@intel.com>
 <CAHk-=whX59mtUnU2ayMWoDQX6Ee2NXLK2NxQ+dZnb-Qc_mF1hw@mail.gmail.com>
 <af9278d3-4002-4e09-9bcf-bc75d1cf8145@lankhorst.se>
 <CAADWXX-pfvA3mKWSjdahnihAXHQB2VP9BOJDCXonG3Q_nxurLg@mail.gmail.com>
 <anYZ8nUFP5dnRy/h@gsse-cloud1.jf.intel.com>
 <CAHk-=whyk2-u_1bTh5ZTeX6jW3HgAtjJh0mV_oWtgsqCe=3w7g@mail.gmail.com>
In-Reply-To: <CAHk-=whyk2-u_1bTh5ZTeX6jW3HgAtjJh0mV_oWtgsqCe=3w7g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 20 Aug 2026 20:50:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjJJH-1q6TK45=z0poSE92mp77JLsF3jHeWXibEtJu7EQ@mail.gmail.com>
X-Gm-Features: AcwNN1U_3QIbtj0n8gohWgZzrSIAiCGi0r0JsQODOTr5FIeO--VUUHcQcS8xh_A
Message-ID: <CAHk-=wjJJH-1q6TK45=z0poSE92mp77JLsF3jHeWXibEtJu7EQ@mail.gmail.com>
Subject: Re: drm: xe: Kernel-submitted job timed out
To: Matthew Brost <matthew.brost@intel.com>,
 Matthew Auld <matthew.auld@intel.com>, 
 Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
 Lucas De Marchi <demarchi@kernel.org>
Cc: Maarten Lankhorst <dev@lankhorst.se>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 intel-xe@lists.freedesktop.org, 
 dri-devel <dri-devel@lists.freedesktop.org>
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

On Tue, 18 Aug 2026 at 23:55, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It turns out that now I can generate those drm job timedout issues at will.
>
> [  +1.222075] xe 0000:4b:00.0: [drm] Tile0: GT0: Engine reset:

Ok. I've spent all day today on chasing this down in between merge
window work, since it finally *was* repeatable.

And the fix ends up being basically a one-liner, even if the debug
session to get there was not.

The Xe driver takes the memory address used for the memory stolen for
CCS, and rounds it up to the nearest 128kB area.

And that is very VERY wrong, because it means that the xe driver will
then *use* that part of memory that wasn't at a 128kB boundary. And
the HW engine will too and write to it.

And when that memory happens ot be used for GPU page tables, very bad
things happen.

I bet this also explains some occasional random screen corruption I've
seen - when the memory isn't used for something as important as a page
table, it "only" corrupts random bitmap memory and the like.

I committed the fix as commit 818bebeb63dd ("drm/xe: Don't hand out
the flat CCS storage as usable VRAM").

Adding some people from commit 37173392741c ("drm/xe/vram: fix ccs
offset calculation") to the cc, because that's where the problem came
from. Two years ago. I'm not sure why it became so repeatable for me
now, but some user space behavior change clearly triggered it now
pretty much every single boot.

                 Linus
