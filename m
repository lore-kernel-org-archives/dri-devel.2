Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D87C43602
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 19:06:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B641810F8A1;
	Fri,  3 Jul 2026 19:06:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rFZok0vv";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90F7E10E56A
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 08:09:32 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-380d9481551so320828a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 01:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783066172; x=1783670972; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=w87AnrTB3+K5h4mEbRFEu3fZorqFSIFJ3pSg+bs+2hw=;
 b=rFZok0vvfGugUS/0V/Z+cUtDCDyfLj2NiZSo9ZprBhQF0NwgRpHms18VrlPTPvITKd
 XHvoXw9VFSuASxHzTFqUy/uCkXMJ2UY8W1L1D6rty6CEyMYEjvlSVmU+Xv4Ea/0eBXfU
 VQENUSWubQBLKkYnC0MWcIvHyBm8m1WYwiGQN6mx+QELg3l3ioYpNXYnvXBAHdBwsQ+n
 rNc3kognL6G6KDzbz21wGPgp53hawiap341WZ6cCzDQLLF4u5tEEXEKql2mnDSF0SOuY
 Ofg1hPkSdccdaLGmcNIJnbDYhnehr2pn4XGZzDaJs0PDBPbEa8bX+sUMAeTfJNh1tdl/
 9+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783066172; x=1783670972;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w87AnrTB3+K5h4mEbRFEu3fZorqFSIFJ3pSg+bs+2hw=;
 b=cIbFPxdOPBN4sBUBqkyhNhwfTK4V07pCJCA/rD9nbJ1tMA8DzAvGkIUwN9ihZ+V8DT
 6iFI1bOkKz7cU55zMtggl/3hzihI3BaI41zkKJUoYtCuRcgtOzLUwjKcp3jnDaoPgn3e
 RFYs5fZ3enFl3Db00BBUla5IMWuBXHaQDco4IDcRT0L67L4A0yrRPyhg4FFBVHBOsn7D
 JupY84zb6GvOdPjzFCVMoJ4HQCFbPdPzfD+rK2sztE8r3jWnOACAL3o54d+7x3/N7JQu
 PdY4G/mt1Drvi2V8V6wfKNQYPkPXVaXuf33PIv+e2XrsreYrsr3JTMjmT/uEYHvh8xgs
 5I3Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrSAm0bD9PBXhv+cOuDRBtS6UlWFkBBAXyMEzchpoEvroPVRT2NBl59ds+aOnf6O3FSWUB/XDNIyOQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy34gQa9HKy0QUA7WCSKzS8y1RjSgDRNOOOUjbGUCOlU3VLiT/i
 4c641jFhCcrf9LKQQmkv8jdYZpgM43SI1zFNJKL2LCTSBB1HmVzu64dM
X-Gm-Gg: AfdE7cl/eh+RrDDjkfYS0Nyecx9tPSy7qlIURk/VsS9zx1SA5EjZzoGqNUx22n4H3+N
 IM+exxcxXM2tkgFAJ6vxu+lY/+zVd8A7HU3B54jdjkZXjENLB4RbsIhXv7ELl4KmBwL9F22zjr2
 0+NN36ViWc+H9O/ZAQgWTQ1FFfIH+QbRN+XmYo5Ag4IfLzIBSHhjveD4uCMz1eAzk1pHjn2hBJS
 bFmxldAqzqksuPpHA0va4R+GLpkWtuoGZ7NAvwmq+WKlMrYepv6HTJYs+YY/L5M0LPXOS3lf8Lu
 KB1LOX5o/PljvNAw9iR1Q4/h3P44gQK7TcGfnodCgE6UBHkMev6TgMSuaPPrp8E9gNeL6SG0TkG
 vM44UjWQ7wMqTB/y0wilqncW9QaFdiNLzWAeS48NLSgkLSIDnGZV/20Gch1jcMKy+AfW5m263Uw
 hhB0PBvEonJC4R3dVmbujAAM8mmh+sc1yMhTtYjHj/0SXXA7co0OEA9w==
X-Received: by 2002:a17:90b:1d8d:b0:381:20b:a9ee with SMTP id
 98e67ed59e1d1-381020baa35mr4976082a91.14.1783066171845; 
 Fri, 03 Jul 2026 01:09:31 -0700 (PDT)
Received: from localhost.localdomain ([45.67.201.99])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38127ae18f7sm614923a91.3.2026.07.03.01.09.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 01:09:31 -0700 (PDT)
From: Baineng Shou <shoubaineng@gmail.com>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 "T.J. Mercier" <tjmercier@google.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Sandeep Patil <sspatil@android.com>, "Andrew F. Davis" <afd@ti.com>
Cc: Baineng Shou <shoubaineng@gmail.com>, stable@vger.kernel.org,
 linux-media@vger.kernel.org (open list:DMA-BUF HEAPS FRAMEWORK),
 dri-devel@lists.freedesktop.org (open list:DMA-BUF HEAPS FRAMEWORK),
 linaro-mm-sig@lists.linaro.org (moderated list:DMA-BUF HEAPS FRAMEWORK),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] dma-buf: dma-heap: close installed fd when copy_to_user()
 fails
Date: Fri,  3 Jul 2026 16:09:22 +0800
Message-Id: <20260703080922.1838362-1-shoubaineng@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 03 Jul 2026 19:05:53 +0000
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

DMA_HEAP_IOCTL_ALLOC allocates a dma-buf and installs an fd into the
caller's fd table via fd_install() before dma_heap_ioctl() copies the
result back to userspace. If the trailing copy_to_user() fails, the
ioctl returns -EFAULT and userspace never learns the fd number, but
the fd (and the underlying dma-buf reference) remain in the caller's
fd table and are leaked for the lifetime of the process.

The failure is easily reachable from userspace: pass a struct
dma_heap_allocation_data that lives in a page whose protection is
flipped to PROT_READ between copy_from_user() and copy_to_user()
(e.g. via mprotect()). Each such ioctl leaks one dmabuf fd; repeating
the call quickly fills /proc/<pid>/fd with anonymous "/dmabuf:"
entries that only go away when the process exits.

Fix it by closing the installed fd (and clearing the fd field of the
kernel-side copy) when copy_to_user() fails after a successful
allocation, so the error path matches what userspace observes: no fd
was returned, therefore no fd is left behind.

Fixes: c02a81fba74f ("dma-buf: Add dma-buf heaps framework")
Cc: stable@vger.kernel.org
Signed-off-by: Baineng Shou <shoubaineng@gmail.com>
---

Reproducer (full source, gcc -o poc poc.c; run as root):

    // poc.c -- leak one dma-buf fd per DMA_HEAP_IOCTL_ALLOC
    //          when copy_to_user() fails
    #include <fcntl.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <unistd.h>
    #include <sys/ioctl.h>
    #include <sys/mman.h>
    #include <linux/dma-heap.h>

    int main(int argc, char **argv)
    {
        int n = argc > 1 ? atoi(argv[1]) : 100;
        long ps = sysconf(_SC_PAGESIZE);

        int heap = open("/dev/dma_heap/system", O_RDWR | O_CLOEXEC);
        if (heap < 0)
            return perror("open"), 1;

        for (int i = 0; i < n; i++) {
            /* Put a valid request in a page, then make the page
             * read-only: copy_from_user() still succeeds and the
             * dma-buf is allocated and fd_install()'d, but the
             * trailing copy_to_user() fails and the fd, never
             * returned to us, is leaked.
             */
            struct dma_heap_allocation_data *req =
                mmap(NULL, ps, PROT_READ | PROT_WRITE,
                     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);

            memset(req, 0, sizeof(*req));
            req->len = ps;
            req->fd_flags = O_RDWR | O_CLOEXEC;

            mprotect(req, ps, PROT_READ);
            ioctl(heap, DMA_HEAP_IOCTL_ALLOC, req);  /* -EFAULT */
            munmap(req, ps);
        }

        printf("done: check ls -l /proc/%d/fd for %d leaked fds\n",
               getpid(), n);
        pause();
        return 0;
    }

Before the fix, ./poc 10 leaves 10 anonymous dmabuf fds in the
caller's fd table:

    # ls -l /proc/$(pgrep poc)/fd
    lrwx------ 1 root root 64 Jan  1 00:03 3 -> /dev/dma_heap/system
    lrwx------ 1 root root 64 Jan  1 00:03 4 -> /dmabuf:
    lrwx------ 1 root root 64 Jan  1 00:03 5 -> /dmabuf:
    lrwx------ 1 root root 64 Jan  1 00:03 6 -> /dmabuf:
    lrwx------ 1 root root 64 Jan  1 00:03 7 -> /dmabuf:
    lrwx------ 1 root root 64 Jan  1 00:03 8 -> /dmabuf:
    lrwx------ 1 root root 64 Jan  1 00:03 9 -> /dmabuf:
    lrwx------ 1 root root 64 Jan  1 00:03 10 -> /dmabuf:
    lrwx------ 1 root root 64 Jan  1 00:03 11 -> /dmabuf:
    lrwx------ 1 root root 64 Jan  1 00:03 12 -> /dmabuf:
    lrwx------ 1 root root 64 Jan  1 00:03 13 -> /dmabuf:

After the fix, only /dev/dma_heap/system remains open; the
anonymous "/dmabuf:" entries are gone.

 drivers/dma-buf/dma-heap.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
index a76bf3f8b071..0dd7a84b06bf 100644
--- a/drivers/dma-buf/dma-heap.c
+++ b/drivers/dma-buf/dma-heap.c
@@ -18,6 +18,7 @@
 #include <linux/uaccess.h>
 #include <linux/xarray.h>
 #include <uapi/linux/dma-heap.h>
+#include <linux/fdtable.h>
 
 #define DEVNAME "dma_heap"
 
@@ -181,8 +182,16 @@ static long dma_heap_ioctl(struct file *file, unsigned int ucmd,
 		goto err;
 	}
 
-	if (copy_to_user((void __user *)arg, kdata, out_size) != 0)
+	if (copy_to_user((void __user *)arg, kdata, out_size) != 0) {
+		if (kcmd == DMA_HEAP_IOCTL_ALLOC && ret == 0) {
+			struct dma_heap_allocation_data *h = (void *)kdata;
+
+			close_fd(h->fd);
+			h->fd = -1;
+		}
 		ret = -EFAULT;
+	}
+
 err:
 	if (kdata != stack_kdata)
 		kfree(kdata);
-- 
2.34.1

