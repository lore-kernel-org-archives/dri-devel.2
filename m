Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEAD606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 14:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KGHaHSkP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 343A310EE40;
	Mon, 23 Nov 2026 14:16:42 +0000 (UTC)
Received: from mail-yx2-f3.google.com (mail-yx2-f3.google.com [74.125.224.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A89F589E69
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 12:27:02 +0000 (UTC)
Received: by mail-yx2-f3.google.com with SMTP id
 956f58d0204a3-67df43056e9so100731d50.1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 04:27:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795436821; cv=none;
 d=google.com; s=arc-20260327;
 b=jd3NnxutwS5tjUpvSzetzN+9owrHBfvv7WejGnJkydB7Xllz+e+ecPui9PEVkz8tWb
 So5ZiMEWTtXVhETEtB/H0P/ywrejctw/W+r5PcMID7io/xV3/4gMc0DDnXTCKO35m9l6
 PM2X9h9Kp5QZCakBb4o9DC6ISYlFRBepW0lRSHXDiEmCu9KOlqdyxTV/d+t2P+dRaLgh
 lk2w44pfw+7s4sxiLVo49dw8uwoWlD4uy42cAF0sNcoezsaviCr8iFVELBoSSYNIqQag
 WoecJ40FxCuzDGrFDdr9+dADWVDtdnzeajkG1TzH7ets9ZQET84Nt+F7d6dyk+HT/g6P
 kjDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=LTCbzp3wPjAa3PPINui96qB48/BqwldK5KKPmBxejnc=;
 fh=HZq/FIZW/hfW2y9gvWOjl4tQnWYRIzFjK9J9g3jTYHg=;
 b=jtCRAM24ki64ZUGEjPPh5O9sYeJCujsaGV+2vxFt7oG5RT0HQ4C75ksCzRn1UvDwcw
 DIkGzq26osbjSF016hWEGIYeRifo2rMNqLRWUrrv+nevqTHsx3lxrm4xdWqhIE3Oiwpj
 z+lj/2nqJHtDtflMOMXKR5XX3kqsiYH8qICUSrCBT236jbw6Jrvkfdz7DacrMmQKxzS0
 7vujhTDGWvK/LDfdjGLsfmXHhP0VHb6kAInDHuP44aQh6TOs+LeV6Du1TaoITF1SAcXB
 1x+qIRuKCn4dkXojgWNtvG7Yvc+apG9l5xsifGvH9ipZAVdd0fqAbIOTgySoMgsSqZCp
 Be0A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795436821; x=1796041621; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LTCbzp3wPjAa3PPINui96qB48/BqwldK5KKPmBxejnc=;
 b=KGHaHSkPpsGvvhw/K/UHDyocbXUg7B9a7BwSB8pPvys7tZm0aqj0EprX02e19y/1Vw
 eHlWw5gcOl91V1l5ULBo8zyX/g8HYzdxDZ2SgBx8SRU9ODf8J55UZtslsIdDf4f1/3nr
 x3W+fIpUz8l3fv6yCrAt7u/eU9biuVXyeXqRGz4AISik8ay2MgEQEXVySrxc58tRMyG1
 W9rvwSx6/zAMLs8qRcpCJs7e63J/DQRlP68nouEzZ99PHR1TF3y1LMTh8F9JqTNks2lP
 /6CFIpwnozLSeg+rFCQ1haKEVD9XK0d5A6aOduKQV2O6oci35i6NmQVtaMDGmJS7SQ1B
 ExGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795436821; x=1796041621;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LTCbzp3wPjAa3PPINui96qB48/BqwldK5KKPmBxejnc=;
 b=P5hX8FLpUcdIt5GIYfoodLTPjWFAWc0h2TCFc06UZyoyFzoKUXWRq0rZrziqzhWv9m
 CAW16kEdS5N2lEnSIup+353ejzNiRZrl2HYKRkjjioGj3GUCjj8+526aLdvPOUu0LFr6
 ef/lRt4r5Ru2IeeaWXsPXv2ECrnavQpuSFD+gu9+EfVatao4iZwHo2bx7xJtx8Q6fzAQ
 4H7vT/q6viGx+gi9rUQVJ5NxVum4pVG/SsPX/wmWkX/DB1U/cRtU3Pk4DyfURLBcAOln
 //xuK02d+gVJDIDz3Wd2+FH+LsYktvy10kddWHkp6Y7JHPmzAn9dUvr1+sU03gzPSHrE
 MEfw==
X-Gm-Message-State: APuU4Z+VN70NrEbdvr58OsR1aqpUnETxpeReRQ5UnC1d23nz9MtNoGuu
 piow/0kfwF+cBfNSi83UfFrNUNfe1SSqTITr1PkOT89ugOIHmL7HX7S6Ehvv7ieWjVRNyMt47rP
 SRI5XUKpU/cvQhEorNlNgBEwY9yF7dnI=
X-Gm-Gg: AZFdTZduIEkXA2FJ7V8csyUkFP5JylBQ2K5iUQKWefERf/P+zUi6M+PtlzDntVHCDaE
 b8M4ssyDUgtIoe+aNbSb4ekD6qzuiHOoKIvFKBLF6tU198+sqzefNYoTftpYUUzKhpl3fmg0Db8
 K8vZXlwEWrldZ8Jh7jtGq0zH749Gs/MMbVqDNWGPHO+IR8+LGlXsCK0rGZHkUIBNHabHv9Ti3bC
 GBAIxlyJsGFVSsesRh+8wVkUihyAezG3ozJUWrmtLRlJ5a0iOZiv0uTWMwwihFy5+HTzCyXTvmq
 K97GZa0Wvn8KSD4hUw20Bse8M1ktOKcrFYRK1ZDpLmHeERtNfV0KCmoni1I1LrssxmbTx7zbkz8
 aBy+gd9fctowwnH8y72hA9q3UVSSUGFIGmtY=
X-Received: by 2002:a05:690e:12cf:b0:67d:b5fe:1cdf with SMTP id
 956f58d0204a3-67df42dfc19mr9852162d50.2.1795436821671; Mon, 23 Nov 2026
 04:27:01 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Mon, 23 Nov 2026 06:27:01 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: peisong0528@gmail.com
Date: Mon, 23 Nov 2026 06:27:01 -0600
X-Gm-Features: Aa3M54oMMnWLYvHMYGJ7y3zFUimXawju23uwIBDnXMUikqW2z5F6AIed0pC0gKA
Message-ID: <CALbj1i7RyG383Ay7gPwXuVC+NN=K9ra-VM3AtO3q8nskZJkcPg@mail.gmail.com>
Subject: drm/ttm/tests: KUnit coverage for a busy eviction candidate
To: nat@pixelcluster.dev, arunpravin.paneerselvam@amd.com
Cc: dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 23 Nov 2026 14:16:40 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

I'd like to work on the TODO in drivers/gpu/drm/ttm/tests/TODO for a
KUnit case where the only evictable buffer object is busy. Is anyone
already working on this case? If not, I'd like to take it on.

Thanks,
Peize Song
