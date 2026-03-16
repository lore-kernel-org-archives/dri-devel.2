Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8EEF53D81
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 18:09:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6DBA10E088;
	Mon, 16 Mar 2026 18:09:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=nppct.ru header.i=@nppct.ru header.b="eRmVWXNh";
	dkim-atps=neutral
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E5C910E088
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 18:09:23 +0000 (UTC)
Received: from mail.nppct.ru (localhost [127.0.0.1])
 by mail.nppct.ru (Postfix) with ESMTP id 86F671C0F99
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 21:09:21 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
 reason="pass (just generated,
 assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
 in-reply-to:from:from:content-language:references:to:subject
 :subject:user-agent:mime-version:date:date:message-id
 :content-type:content-type; s=dkim; t=1773684561; x=1774548562;
 bh=YURiV9pptYTQKRccB/77x8YtapLBcnScNw7i1orzlhM=; b=eRmVWXNhx2Be
 hPlvMASTJhJfM84/ztC8d4qNs9ghaIxu4ZnV/2DD7NsqvJzZlOOF/gf9lnjaSylk
 +le3/SKpK2A+qXDPpFVUcAB4jSOpKkodrgJazyNnU386Oiaiap/u0Y4dLKxr8LIb
 OB6wM7DzoXzLJKI0gI2CemTSDDhbwkk=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
 by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id qjOKRign6g56 for <dri-devel@lists.freedesktop.org>;
 Mon, 16 Mar 2026 21:09:21 +0300 (MSK)
Received: from [192.168.1.67] (unknown [46.72.108.30])
 by mail.nppct.ru (Postfix) with ESMTPSA id B39071C0E83;
 Mon, 16 Mar 2026 21:09:19 +0300 (MSK)
Content-Type: multipart/alternative;
 boundary="------------6ieCqH3cGP44nV15ppG6N5YP"
Message-ID: <4dcb40c5-0a11-4e25-822b-98f5883751aa@nppct.ru>
Date: Mon, 16 Mar 2026 21:09:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/nouveau/disp: Fix potential NULL pointer dereference
 in nouveau_dp_irq
To: Timur Tabi <ttabi@nvidia.com>, "lyude@redhat.com" <lyude@redhat.com>
Cc: "bskeggs@redhat.com" <bskeggs@redhat.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dakr@kernel.org" <dakr@kernel.org>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20260316172631.82304-1-sdl@nppct.ru>
 <ac4867a4c6da6aef61b189960c0142a660b2122b.camel@nvidia.com>
Content-Language: ru
From: SDL <sdl@nppct.ru>
In-Reply-To: <ac4867a4c6da6aef61b189960c0142a660b2122b.camel@nvidia.com>
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

This is a multi-part message in MIME format.
--------------6ieCqH3cGP44nV15ppG6N5YP
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

> Can you provide an example of how/when this would be the case?

The issue was discovered through static analysis after reviewing changes 
introduced
by commit 773eb04d14a1 ("drm/nouveau/disp: expose conn event class").

Originally, nouveau_dp_irq() checked the result of find_encoder() before 
using it:

     struct nouveau_encoder *outp = find_encoder(connector, DCB_OUTPUT_DP);

     if (!outp)
         return;

Commit 773eb04d14a1 introduced the line:

     struct nouveau_drm *drm = nouveau_drm(outp->base.base.dev);

before the existing if (!outp) guard. As a result, outp is now dereferenced
prior to the NULL check. The patch simply restores the correct ordering 
by moving
the initialization of drm after the outp validation.

--------------6ieCqH3cGP44nV15ppG6N5YP
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><span style="white-space: pre-wrap">
</span></p>
    <blockquote type="cite"
cite="mid:ac4867a4c6da6aef61b189960c0142a660b2122b.camel@nvidia.com">
      <pre wrap="" class="moz-quote-pre">Can you provide an example of how/when this would be the case?</pre>
    </blockquote>
    <p>The issue was discovered through static analysis after reviewing
      changes introduced<br>
      by commit 773eb04d14a1 ("drm/nouveau/disp: expose conn event
      class").<br>
      <br>
      Originally, nouveau_dp_irq() checked the result of find_encoder()
      before using it:<br>
      <br>
          struct nouveau_encoder *outp = find_encoder(connector,
      DCB_OUTPUT_DP);<br>
      <br>
          if (!outp)<br>
              return;<br>
      <br>
      Commit 773eb04d14a1 introduced the line:<br>
      <br>
          struct nouveau_drm *drm = nouveau_drm(outp-&gt;base.base.dev);<br>
      <br>
      before the existing if (!outp) guard. As a result, outp is now
      dereferenced<br>
      prior to the NULL check. The patch simply restores the correct
      ordering by moving<br>
      the initialization of drm after the outp validation.</p>
  </body>
</html>

--------------6ieCqH3cGP44nV15ppG6N5YP--
