Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46491C5DF80
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 08:32:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B6ED10E0D2;
	Tue, 18 Aug 2026 08:32:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ngZCna4b";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55B7310E0D2
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 08:32:11 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so41488045e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 01:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787041930; x=1787646730; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QG/UVFd2ACFMYaMnp0CQ6c77bR9FNNHaHabNi47aSho=;
 b=ngZCna4b8tAbDzhdwn9WEBP77UV+1znuwKRSPD4YccJjAgQ++rs8bd6+F7n0n/BPz4
 DfxUTqW/OScBhU21she9IX/l+4ffeyXNa51EztkfyWx0H9ruU2FoTW4lfxgyt7xfUHE+
 I+Jh21+dBYsOFnzYCSHNkw1iImDBZc6jAZm/eskI4AIoA1UFdFeZnSbWwUk4GDHZ7KKe
 IOyx34rsGyktIy++z1U6sSKzFdBX9WSzTxwMH7V6LgbbxQDZdMDZvDZBxZ1o2bVtNrk0
 Gf0ETwXcq8nSPFJUorUgjgBpWfzNeb5xcKMFl0E2liQ9PCxHqzg+EoYewbixk0b2YkMW
 4PEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787041930; x=1787646730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QG/UVFd2ACFMYaMnp0CQ6c77bR9FNNHaHabNi47aSho=;
 b=HjkOXaB3P3ExifEVH+IbL2LMyGx4reim409cwtiBQs9NvY8Czb7VqPU09mO36TgV7s
 IeSOSn5OGV94afD1klGuocSb6l5eGC6dshHS4GM90tY4XrBmc43dbvPCM1iaDJbqyCEa
 9FKL4vsBR7XOuns1AZ9GPCziXv8oAXDlGh4oAv/FaT9iT5ZJcpsnJI2TLKk7kFHKWsPD
 v0fwNvu7vndOQPRciXrfinJUUW7zOdW36Ye5czzduHgXDdRSYl8USW2uKPhRVapsYXbB
 eO1MdP/ukmo0jp+XLrseAqXp9Udies9X2PzdNEPwi7tnVFctTGEyVlXahT7PijzVaglo
 2yRQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqrb+lRDE18s9Scf6Cbahz24i2nOKlKqB/lAwiJGo0GsC7zbGYhpn2hiuRSppZROrrVnQVc+YDsM5Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxlTr83aEI/d4WLnNuWcGgWinlCRvM4ecvLI30OoOFYu/E32veR
 yYjDwNijdRcRvZNDQNUEK/Zrqt5GR2JLW9WNaql14E27DEGEq5T9T65N
X-Gm-Gg: AR+sD13TuhD66yOqu6KoTWrnHwhEudchd5Wux5NvGnsrj7pV0rSs7t9578K8BHtm9kz
 3TYKBHvQ8y0BrpSt2iVPFfmw8NsXfnOZuGQqppaGl6mNWHvkv2XSQIJBLH4lRAs4gWLM26hVg6B
 KTXtRS4jjT04AmSU9DkHFDzatMZBrHuivkNB9H/lAK5OqIgV8mVk9JZxGT0ujlOTXIvUXLCpdNk
 d8A3BI3jv4si32hKHH5wqjJE9l0C5/wIGmNQ7xMV6ees2skyB/vcrWOnfpjDrojh8C3YIOXO4La
 FCLkp2sF6Kmw9YzDOC60LBBF8QDv5dC9lANpOOpzFJlrJhXK8h9ASIL/L2GPW+f20iUUNOV3v9C
 agk98RSwPRAQr0CmVtc6UDQ9SiSIr0F4J25OkJgew8oOFBpHIsSWq2+xqPEMSMtPHWuhZ/joD0d
 dznMEul3E74XZUlQCKmq3R64VZ75OnZi7fKwq5HFwTmR8akklpFdHyhRgY8Cm5GE+m/U0qxkVSd
 HhZygyftOTLZg==
X-Received: by 2002:a05:600c:5397:b0:493:bb6b:5bb5 with SMTP id
 5b1f17b1804b1-499879857d0mr519017545e9.13.1787041919339; 
 Tue, 18 Aug 2026 01:31:59 -0700 (PDT)
Received: from anthony.local ([2a06:c701:9cc4:c200:33d8:8ea2:e077:ebe1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996109652sm289304505e9.4.2026.08.18.01.31.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 01:31:58 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: Fabio Piparo <holofermes@gmail.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/ssd130x: Set the address window in
 ssd132x_clear_screen()
Date: Tue, 18 Aug 2026 11:31:40 +0300
Message-ID: <20260818083143.37939-1-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817152500.703770-1-holofermes@gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Fabio,

> ssd132x_clear_screen() sends its zeroes without setting the column and
> row ranges first, so they land in whatever window the last
> ssd132x_update_rect() left programmed.

Good catch, I noticed the same asymmetry. But as Sashiko pointed out and
you confirmed, ssd132x_clear_screen() is not reachable today, so there is
no user-visible bug being fixed here. I don't think this should go to
stable, and I would drop both the Cc: stable and the Fixes: tag in a v2.

There is a second reason the clear cannot work in its current form. The
driver does not override .atomic_commit_tail, so
drm_atomic_helper_commit_tail() runs
drm_atomic_helper_commit_modeset_disables() before
drm_atomic_helper_commit_planes(). By the time the plane's atomic_disable
runs, ssd130x_encoder_atomic_disable() has already sent DISPLAY_OFF and
called ssd130x_power_off(). So even with the !plane_state->crtc guard
fixed, the clear would be writing pixels into a controller that is
already powered down.

None of this makes the patch wrong - I do believe in making functions do
what they are supposed to do. It does mean this is a cleanup rather than
a fix, though, and that it cannot be verified on hardware until the
disable path itself is sorted out.

> +	ret = ssd130x_write_cmd(ssd130x, 3, SSD132X_SET_COL_RANGE, 0, columns - 1);
> +	if (ret < 0)
> +		return;
> +
> +	ret = ssd130x_write_cmd(ssd130x, 3, SSD132X_SET_ROW_RANGE, 0, height - 1);
> +	if (ret < 0)
> +		return;

This duplicates the window setup that ssd132x_update_rect() already does.
I would rather see those two commands factored out into a small helper
(e.g. ssd132x_set_window()) and called from both places.

Note that ssd132x_update_rect() cannot just be called from
ssd132x_clear_screen() the way ssd133x_update_rect() could be from
ssd133x_clear_screen(): it takes the R8 shadow buffer and packs pairs of
pixels into data_array, and clear_screen() only has the data_array from
the CRTC state. In the SSD135x series I have in flight,
ssd135x_clear_screen() does call ssd135x_update_rect() with a full-screen
rect, but only because no pixel conversion is involved there.

-- 
Thanks,
Amit
