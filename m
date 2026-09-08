Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE555C79FA1
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 12:03:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E81910EB9D;
	Tue,  8 Sep 2026 12:03:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="FA8tqAUW";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7B7410EB8B
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 12:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788868986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lje7LxotFN8OQu8fgaVYYDvIYFBd+T6ZwNc+aWkYRdg=;
 b=FA8tqAUW8nn/lkVv9xJvt91QWURgGmGLZFx8sfBtbgWJrMCGmJ0/o8VlfROri23K2msMQD
 UKvvxELmjcaMPi7rY0KCcKZsS+amCFJ7g+Xb+e4QdGyXmtEUB1cZ0cKlfZte3fDLTPvpiS
 jYDGdHocQC6FT0UKX0LQxUg4EGJe1Mo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-jFAR2SzONU-bV-V3Qnq4iQ-1; Tue, 08 Sep 2026 08:03:05 -0400
X-MC-Unique: jFAR2SzONU-bV-V3Qnq4iQ-1
X-Mimecast-MFC-AGG-ID: jFAR2SzONU-bV-V3Qnq4iQ_1788868984
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49cd74fc1aaso26243325e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 05:03:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788868984; x=1789473784;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Lje7LxotFN8OQu8fgaVYYDvIYFBd+T6ZwNc+aWkYRdg=;
 b=qDgqAwvtCJaYWc0J+peMTYbb5VEVRBDQ01ajLh2uvisVLo4P/bolrX30ZFYAACiQYb
 SpTWanseX6jtdNMxagXX7Eb+tTrNKrzO8HM6hJvrImFCFuN2XspKvV3CvzTLjPL/seLr
 CrQMx31lhFZB+tmi7s4b+M5T023ig11/x1V7P4IGAOrZwwO32cz1/B9u4+MtYFSzMeJq
 uJfy4LTy7gmmPT56n3npqALWzgZli/gB8JNu9rquUFSQhWEZ+xlZVvO10skcwZ2fQ3NN
 liX+h9rTBTGnPOTknoGwxJ/aWXdWEixCZVZJ4BQPyaA7pyAY6/H4YC0O1a5+g0A/tc96
 tpjw==
X-Gm-Message-State: AFuF++lNNPsneBzBMimlaj3XAnuomV/pr50AyD6wutiuE9cp4xRIpWmF
 KTlUSjo82TDGxeKtWlnlzYPO+p26MojDfMZnvbFZTTaB8ZpL2u7SPpw6f4v/m7aqYSK2w3EZWLj
 LdmrtwBEP7e/64kXIS6SoGZUXbJKi2oK/xxa5PFEzlgecoz9ZCo5/BD5o8UmFJC5EzJYnVg==
X-Gm-Gg: AYBFou0Gzywe1A5dU8ibK+8Xo/oFnbHCPIDunH58PDSF3mM0Vdinu3xwPxWYdR3v5QW
 MA/pXJFwsOdZDyFOFsyhrJJXqGjMHqmXLJsTjvBxv8Ycb+MO9xTbhT0NvJm1E1pPLJ3BN4rrTmD
 yhhtSpyrBW6AJsfBhOlR1LG3kUsE8wR4sFxJ4seeX6V8lD6WNeNlNmkVa2ZscXu4bQkVcdXBvKs
 OPuviysgAjn1YUmBfdxF4WSoM6TOQHhPngQyD/kAMUHL0md52eia1P+1YeueQxCVqUXU9TSOwbr
 IPjUzyx6NMdSMMjf2pGXU9X9WpKqV6HTfiTX7QimEyWvJKBG5aBQoumqBW6Tf5laAj/ukWBzX1x
 fZZy7S9QARlPhLlbNDLZ1X3d4KP5jqgxDgkB1Uay7pvGWj9PaNd2ZHhsTyA==
X-Received: by 2002:a05:600c:620b:b0:49c:fa20:cc07 with SMTP id
 5b1f17b1804b1-49cff19cbf4mr224225255e9.30.1788868984220; 
 Tue, 08 Sep 2026 05:03:04 -0700 (PDT)
X-Received: by 2002:a05:600c:620b:b0:49c:fa20:cc07 with SMTP id
 5b1f17b1804b1-49cff19cbf4mr224224635e9.30.1788868983804; 
 Tue, 08 Sep 2026 05:03:03 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d07a23e85sm273590305e9.5.2026.09.08.05.03.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 05:03:02 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Amit Barzilai <amit.barzilai22@gmail.com>, Fabio Piparo
 <holofermes@gmail.com>
Cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/ssd130x: Set the address window in
 ssd132x_clear_screen()
In-Reply-To: <20260818083143.37939-1-amit.barzilai22@gmail.com>
References: <20260818083143.37939-1-amit.barzilai22@gmail.com>
Date: Tue, 08 Sep 2026 14:03:01 +0200
Message-ID: <87v78glzm2.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qL0D8E2yGtjQ1JjDiBMFvig1JuxReG37W6WtLxLpIvs_1788868984
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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

Amit Barzilai <amit.barzilai22@gmail.com> writes:

Hello Amit,

> Hi Fabio,
>
>> ssd132x_clear_screen() sends its zeroes without setting the column and
>> row ranges first, so they land in whatever window the last
>> ssd132x_update_rect() left programmed.
>
> Good catch, I noticed the same asymmetry. But as Sashiko pointed out and
> you confirmed, ssd132x_clear_screen() is not reachable today, so there is
> no user-visible bug being fixed here. I don't think this should go to
> stable, and I would drop both the Cc: stable and the Fixes: tag in a v2.
>
> There is a second reason the clear cannot work in its current form. The
> driver does not override .atomic_commit_tail, so
> drm_atomic_helper_commit_tail() runs
> drm_atomic_helper_commit_modeset_disables() before
> drm_atomic_helper_commit_planes(). By the time the plane's atomic_disable
> runs, ssd130x_encoder_atomic_disable() has already sent DISPLAY_OFF and
> called ssd130x_power_off(). So even with the !plane_state->crtc guard
> fixed, the clear would be writing pixels into a controller that is
> already powered down.
>
> None of this makes the patch wrong - I do believe in making functions do
> what they are supposed to do. It does mean this is a cleanup rather than
> a fix, though, and that it cannot be verified on hardware until the
> disable path itself is sorted out.
>

Agreed with your points.

>> +	ret = ssd130x_write_cmd(ssd130x, 3, SSD132X_SET_COL_RANGE, 0, columns - 1);
>> +	if (ret < 0)
>> +		return;
>> +
>> +	ret = ssd130x_write_cmd(ssd130x, 3, SSD132X_SET_ROW_RANGE, 0, height - 1);
>> +	if (ret < 0)
>> +		return;
>
> This duplicates the window setup that ssd132x_update_rect() already does.
> I would rather see those two commands factored out into a small helper
> (e.g. ssd132x_set_window()) and called from both places.
>

Indeed. For ssd130x we have ssd130x_set_col_range() and ssd130x_set_page_range()
which do some sanity check before sending the commands to the display controller.

Maybe instead of a ssd132x_set_window(), we could add ssd132x_set_col_range()
and ssd132x_set_row_range() ?

> Note that ssd132x_update_rect() cannot just be called from
> ssd132x_clear_screen() the way ssd133x_update_rect() could be from
> ssd133x_clear_screen(): it takes the R8 shadow buffer and packs pairs of
> pixels into data_array, and clear_screen() only has the data_array from
> the CRTC state. In the SSD135x series I have in flight,
> ssd135x_clear_screen() does call ssd135x_update_rect() with a full-screen
> rect, but only because no pixel conversion is involved there.
>

Correct.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

