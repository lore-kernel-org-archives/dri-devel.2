Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B45BCCA463
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 16:15:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B7421122E4;
	Thu, 15 Oct 2026 16:15:14 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6962112233
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:11:09 +0000 (UTC)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-93c5b7f5bfaso210035785a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 02:11:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792055468; cv=none;
 d=google.com; s=arc-20260327;
 b=HAbPZ4oZJSBnV1wHrL9slG5Rxnrq4cQqUP/CEyTRjKwanN+TvAI/RHXQn+01xySwjA
 w9Xs7aBbhB8mpr1GleEdWFXF+BmGgccRlRAvvrhODA8L9jhrVbRqREXmstnYRl+0OfJx
 aEaruSfQnMPauhKoKSPYZcoZbMwtcReFTPB0Z+yC2f9/2E36/ycUAKlNbS+vuRKB71pQ
 AMFZdLM48+w/xPg/LqKfjv5ZB1pzqnMGXEFqI20NrA3+rH+EDFLl87KQG5GcIHCl55SN
 EUIUBm3YGBqQmDnxJXXZ8YZBJIO5CnZnhelrCA8P4U/d10YNHP2ScfeYTAMpkpq9iAHX
 tKRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jEoeOoyKShfauUM6omyrvuy8JMoL6O15hulliMOGIOA=;
 fh=cK/UewRGO+5+n66WlRLBKs5mE0LI6pwf46iMcr+sJk0=;
 b=FZCWvoPsgWd09kQIV8DDpzPBN5OwaVVcCJeza6NcNOIhYcSYGIF+B+S4IyZZA+O5tU
 Q0OBjLhMdBrgT10kCI/TymIHVCBqhIWq28L9q3uji5ySnrm2YmzmY+5fPjtGJVtiscRK
 oM+XASOf9mcq8OYFvNNwkhdC0d3+5NMs1R9EmyT8um2i1fTRB0cFvMylDcmlQ45/MUWj
 2wStI7PTzhw9kJqJFDwIuX4mAFrAs+6+gQ5M1JS2pglYBukFQI7EZHbu4t9FkKOG2/RQ
 p7HKNEaLltsMUMYnFxVNIz3UF1AccTNNAphMpWEXLFnG5n5J/QNT5qR8ZA3Z4Z4nHQy6
 SFyg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792055468; x=1792660268; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jEoeOoyKShfauUM6omyrvuy8JMoL6O15hulliMOGIOA=;
 b=bA0oMtBlREg8pitz69UjrYJKVRFWZJvzUPLA5SczzxHRTzAcnh+pDOwfH6zif+/I13
 VFtkDfPAAJctN8XfzLQwEfr2kYSX8IkfwjvDaTkQe8qfOr8CHjv9kXDAB3UIaOjpxJd1
 tiCJRF5fCpfVVEbeiY9FWCDTKAakjQQYzNMxGz8LBMhvRFDgWd8f2w3kbEVN1YXBZFGI
 XsoUE5SIOxCWPGNx6rwf5owCjaFucrb1GVvTKQuchUPNlMgbewXjS0v8YgSSvcaQVHY6
 Dqon8EQcbc655/Y5L8KEsxfk42SYcbJs+eA3T5AB3rWPYRV/1klBvOs3gv0ENjhCbV7d
 jGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792055468; x=1792660268;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jEoeOoyKShfauUM6omyrvuy8JMoL6O15hulliMOGIOA=;
 b=U+YGNMhCwzi1o5oj3lV6hTdk5jlW5Jp3eFC6bH7jjKkUFxGBVWxDemiDJN8JnOfJZN
 6q+i5aLffrstCwSc8NtwCCUFaJEC40v/m8xlapuXJKRGyCwDxBWoRFfQbxoSPgvsiaGP
 QIu0sluIQNP7FUtPpLYIqDAczvCOW4mLs8wRq5e3aLTafHozr+UCRY6XpoLZkLoKrNMl
 ZMRWg+7/jfRVSTQe5ZRWqsgEnQ/FsWtzE0LZKPmf5r9fOAlLpUdQ8cHoWdibYjEMxBa9
 KqQolyij8mJr3lyc4gOxUpUa6LbCgMuCE/lIQL1oByD3qnn5gP2VPKaZ7eQzUIngQlw2
 gMjA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzo2vqpu/8PP8imx0x9SqHAC6Yd/yKOE6PzpzT2VGG8WGAdcYeUG/r4qgTrIWXSnW9zpVcGtbc9LbU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJJk3XFnSW+Q2p4kgYOXpXbK8os3YL3y05trwYeuBdhXkeFaa6E
 JHXW5zf2FZFwA8yS5kivPIZ1lZWa5UzvYk3qEyoGuq44azd06xJy3/kUsnlovVo45cvp6Am4B6G
 lDZLwjuOFPHoAEMmDRsr0rDvFzsLOLH0=
X-Gm-Gg: AYBFou2M2dWZIj+c2JDzj14ld0DPhbqmVTPOPZjB3bNhuaKe56SjKKX+gJ5KZ4jRu1z
 htfq6JXOQ+7Il9lGwFbsSC7nMJ7uvkeizY2b8HdcCxrm2wbg4/wJedxd2wB37yClaWMs2DIukp8
 lg4GvegF0pDWrwstGSo9HOJ9Yk8ABmlGkBYHVfWTTVHVACbDlDm99mFHMR2hdW0b0PCD5hFJjET
 67nUsxcple4ZZzDx0A2MHABB2btcbVKxPY4zM9b49t2Mi03GMOLiGOBtQLZ5EQsEfbAcHRJRCNS
 Bycdns7DuZsRYjbNqLWw6JOIgtEyITblw0mxhwy7/miD4ZmLZ4wAeBN3RV8cOsnq0ybrQJZlwNk
 kylkg8Dr0S0U=
X-Received: by 2002:a05:620a:2850:b0:93e:94c3:e851 with SMTP id
 af79cd13be357-93ec135054cmr2512973085a.9.1792055468406; Thu, 15 Oct 2026
 02:11:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260928081450.19340-1-dilddream31@gmail.com>
In-Reply-To: <20260928081450.19340-1-dilddream31@gmail.com>
From: =?UTF-8?B?6rmA67KU7ISd?= <dilddream31@gmail.com>
Date: Thu, 15 Oct 2026 18:10:57 +0900
X-Gm-Features: AclHuK9dY7-4Z1BJVfwNpzcd1NSLlAb1ICM3Ix05ep8_FkWQ-f6VLJo26bPN6Nk
Message-ID: <CAGC3ukQ7gX97E7pG0Oy8H0cnmQzoA1038io+VhrBogPB3y9dDQ@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau: Clear fence channel in no-signaling path
To: nouveau@lists.freedesktop.org
Cc: lyude@redhat.com, dakr@kernel.org, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Content-Type: multipart/alternative; boundary="0000000000009cbe2f065ddd6d4f"
X-Mailman-Approved-At: Thu, 15 Oct 2026 16:15:09 +0000
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

--0000000000009cbe2f065ddd6d4f
Content-Type: text/plain; charset="UTF-8"

Gentle Ping.

There has been some related discussion here:
https://lore.kernel.org/r/1690ea65-a1e0-4a34-bde1-bdd26e31c6c4@u-bordeaux.fr

The patch has also been independently tested, with no reproduction of the
issue reported so far.

Thanks.

--0000000000009cbe2f065ddd6d4f
Content-Type: text/html; charset="UTF-8"

<div><div style="font-size:inherit"><div style="font-size:inherit">

<p dir="auto">Gentle Ping.</p>
<p>There has been some related discussion here:<br>
<a href="https://lore.kernel.org/r/1690ea65-a1e0-4a34-bde1-bdd26e31c6c4@u-bordeaux.fr">https://lore.kernel.org/r/1690ea65-a1e0-4a34-bde1-bdd26e31c6c4@u-bordeaux.fr</a></p>
<p>The patch has also been independently tested, with no reproduction of the issue reported so far.</p>

</div></div><br></div><div dir="auto">Thanks.</div>

--0000000000009cbe2f065ddd6d4f--
