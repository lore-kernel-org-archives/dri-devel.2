Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26CCBCD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 08:38:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C34A10E735;
	Mon, 18 May 2026 08:38:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZTG865Cc";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E379110E735
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 08:38:13 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-48fe26a177cso12553135e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 01:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779093492; x=1779698292; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=siW0SAUkqUtqbw5GAYaahr5nvlauOpDk5JY1Ez5XZC0=;
 b=ZTG865Ccl5Qu2Lbaart5BSgRkZWu7oi4KaDmzz6ZVAgwdgJ6x6SBcvQBlY8v2HnYfm
 LeO4JGfPDtyoMIHCnr53zcxIOX03HOxnTjqe80WUB1fiBdCSkT0IX8kxHmFakzrIFyPG
 cf0+k6t1furmTlOHr9xsLUly4qk7zPed3TnnBv0a1Ut5/EduK3B/FO5m5ntXH0IP62he
 C3iiVy1/4sTio3MRQJvLTfs98KGWbSkjlYUL/0NuAq1YGPKBDhb/sXAtgMIUiE0LcumQ
 5AKll0DU1X3B6Gq255Hp4xIGZwGTTIjhRjFKw5U36HozJerpAMb26z8rBz37XZQrUiv7
 P0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779093492; x=1779698292;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=siW0SAUkqUtqbw5GAYaahr5nvlauOpDk5JY1Ez5XZC0=;
 b=hMxmkm3UR4IsvagAlO2Sq4iC2RMNFMpT8nL4OZkBuyVNEoBzXzXvbiuL7Ywmqcmblk
 CPcYIQQRqPnizmDH7WDKoIOwpFG9ZzgryewNY9iQ0F64P49hlEwnMFVp7o6mOv2IEKKi
 fU2/nN3SBPWA4DileihxsA/suWoonkxC0Ld9Z4AYHxkdhifHHTeJ9010ul48FkMQexUA
 IL3JyphnC9sMFT+zb6uWWKdWWs6q41xTLYR+LCWKrjLImzDnuiGv9I1Spw5OvhRYBwmY
 gJDu3yG7SxZKpdQBDDHFkthPPpc64OfwH3bIqO/HXy1x2kqhCbtcLKpEEv0LjvkYAeq5
 43pQ==
X-Gm-Message-State: AOJu0YwBhldrJ+F0csXNxWGhbOkYoWWogFPcLv52KCg7ouCQKCcOjakl
 931vPau3byviITpYUhGjaVx9CXHM0OTWDoLxqKdhcpZygi3aXcps0guK
X-Gm-Gg: Acq92OEQggebruphQXYEfoiO76ATWgkkksQdmbt/T7OMx9cbClY7FTBuZFGlkS+9UUk
 votpR6jQZ+JILa91BhFH3aBtrNfRydjh4gOKQQgbkUETj6KPic/WPKbx/ceWoCrtVlzu6e3kat/
 DLxvx+aC8NRTlcQgrC+ykIQ1mlQQgsR160w0gaWBZBlzkWWFUYzQA351++epYaCoqQ5Hrcabkyd
 JsfWPC3/2bLTuCUSz5mQmAUBHRAoPjeT0iWrmd1D3wnPqnB7TxXIazr51hiiRacxX7LuO2hNeoF
 CtQrHAlKYytd9a/17gRqa+g9uh7swgji56XFo2w9KfRF8XMLlaPkuh5H1klbQLBq3CljdaMwv/Q
 S/JFilJzRPIxrseD/JZVeXXBh1B6a/LL7kHr5MBlMxWMW0Ig2QofkZQ7NBL45h0P+vWg1rzcXkr
 OgQhtcsvxOapL+Bbdo3sjbUdzXNVjkYg==
X-Received: by 2002:a05:600c:5247:b0:48f:d1b8:9aa0 with SMTP id
 5b1f17b1804b1-49007bdff16mr71423005e9.7.1779093492228; 
 Mon, 18 May 2026 01:38:12 -0700 (PDT)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febe60fc0sm89660985e9.21.2026.05.18.01.38.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 01:38:11 -0700 (PDT)
Date: Mon, 18 May 2026 11:38:08 +0300
From: Dan Carpenter <error27@gmail.com>
To: Oded Gabbay <oded.gabbay@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Subject: [bug report] habanalabs: add gaudi asic-dependent code
Message-ID: <agrP8NT6DN8iX7sV@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Hello Oded Gabbay,

Commit ac0ae6a96aa5 ("habanalabs: add gaudi asic-dependent code")
from May 11, 2020 (linux-next), leads to the following Smatch static
checker warning:

	drivers/accel/habanalabs/gaudi/gaudi.c:1036 _gaudi_init_tpc_mem()
	error: dereferencing freed memory 'cb->buf' (line 1035)

drivers/accel/habanalabs/gaudi/gaudi.c
    1022         for (tpc_id = 0 ; tpc_id < TPC_NUMBER_OF_ENGINES ; tpc_id++) {
    1023                 rc = gaudi_run_tpc_kernel(hdev, dst_addr, tpc_id);
    1024                 if (rc)
    1025                         break;
    1026         }
    1027 
    1028 free_job:
    1029         hl_userptr_delete_list(hdev, &job->userptr_list);
    1030         hl_debugfs_remove_job(hdev, job);
    1031         kfree(job);
    1032         atomic_dec(&cb->cs_cnt);
    1033 
    1034 release_cb:
    1035         hl_cb_put(cb);
                           ^^
cb is freed here.

--> 1036         hl_cb_destroy(&hdev->kernel_mem_mgr, cb->buf->handle);
                                                      ^^^^^^^
So this is a use after free.  Free the handle first?

    1037 
    1038         return rc;
    1039 }

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
