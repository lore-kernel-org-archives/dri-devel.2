Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A88CC43602
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 04:46:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF18E10E32D;
	Wed,  8 Jul 2026 04:46:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="vKc5Tjb1";
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D3B110E32D
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 04:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=adWoLdqqX8285InOHHUleyt6hKDQ7O9XUGMsAwczw3U=; b=vKc5Tjb1mGE3FAiO6cHvyHHrpL
 WBg7vEIQL2vHQE6sQ+8FChCGGDNEfyjMTYKy5d5bwMVkoCKc+acGk4iK8N81+5mAjwbcGao2+BVBv
 NobgshllXiCRdDAzqw4REuhLIyN3oiP05FJeV31zxsHzrLoU+yfWFk5e62srSNfI8ZXbeP3YawqbE
 JNgANX7zVUAF/Qy871JHpP1zi1qKfigdEtjDXMwaRk6ttYEnGPtu6UkZ9vqBEHuMAbGwnObP2ld9O
 INgJ/CAQqea6A0ELRrN69tBM/KMud6ZM+XTqD0chBXsXNleQcqo8SdyXPOmZZjMJNWaQGJPozAY5f
 vyY7n9OQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
 by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1whKAl-0000000GKrD-1oZS; Wed, 08 Jul 2026 04:46:12 +0000
Message-ID: <699644e7-2fc2-41b5-9e02-7f4dbc2aa3a7@infradead.org>
Date: Tue, 7 Jul 2026 21:46:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/7] Add documentation for Sahara protocol
To: Kishore Batta <kishore.batta@oss.qualcomm.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mhi@lists.linux.dev
References: <20260701-sahara_protocol_new_v2-v6-0-3a78362c4741@oss.qualcomm.com>
 <20260701-sahara_protocol_new_v2-v6-1-3a78362c4741@oss.qualcomm.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260701-sahara_protocol_new_v2-v6-1-3a78362c4741@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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


On 7/1/26 3:37 AM, Kishore Batta wrote:
> +The packet flow sequence is as follows :
> +
> +1. The target sends the hello packet to the host to initiate the protocol
> +   with the mode set to image transfer pending.
> +
> +2. The host sends a hello response packet with a success status and sets the
> +   mode to image transfer pending after it receives the hello packet and
> +   validates the protocol version running on the target.
> +
> +3. After the target receives the hello response, it initiates the data
> +   transfer by requesting the size of DDR training/calibration data.
> +
> +4. The host sends back the DDR training/calibration data to the target.
> +
> +5. The target decodes the training data and does not find valid DDR
> +   calibration data, target sends END_IMAGE_TX to interrupt the transfer.
> +
> +6. The host sends DONE after receives END_IMAGE_TX.
> +
> +7. The target sends DONE_RESP with mode = IMAGE_TX_PENDING because it has
> +   not received all images.
> +
> +8. The target executes DDR training process to generate valid DDR calibration
> +   data and prepares to push back to host.
> +
> +9. The target initiates protocol by sending a hello packet with COMMAND_MODE
> +   to the host.
> +
> +10. The host sends a hello response packet with a success status and sets the
> +    mode to COMMAND_MODE.
> +
> +11. The target sends CMD_READY to the host.
> +
> +12. The host receives CMD_READY and starts to get command IDs to be executed.
> +
> +13. The target sends CMD_ID = 9 to push DDR calibration data to host.
> +
> +14. The host executes CMD_ID = 9 to get DDR calibration data from the target.
> +
> +15. The target sends RAW_DATA with the payload which contains DDR calibration
> +    data to host.
> +
> +16. The host saves training data in the kernel buffer and exposes to userspace
> +    via the sysfs entry. The host sends CMD_SWITCH_MODE with the mode set to
> +    IMAGE_TX_PENDING to continue booting.
> +
> +17. After the target receives the CMD_SWITCH_MODE command, it sends HELLO to
> +    the host with the mode set to IMAGE_TX_PENDING. The target and the host
> +    repeat the packet flow for image transfer to get all booting-required
> +    images.
> +
> +18. Upon successful transfer of all images, the target sends an END_IMAGE_TX
> +    packet with a success status to the host.
> +
> +19. The host sends DONE after it receives END_IMAGE_TX.
> +
> +20. The target sends DONE_RESP with the mode set to IMAGE_TX_COMPLETE because
> +    it has received all images. The process has been completed after the host
> +    receives DONE_RESP with the mode set to IMAGE_TX_COMPLETE.
> +
> +Subsequent boot scenario with valid DDR calibration data
> +--------------------------------------------------------
> +
> +The below firgure shows the subsequent boot scenario with valid DDR calibration
> +data process being loaded from host to target.
> +
> +.. code-block:: text
> +
> +                        Host                       Target
> +                          |          HELLO            |
> +                          |   (mode = image transfer) |
> +                          |<--------------------------|
> +                          |                           |
> +                          |         HELLO RESP        |
> +                          |   (mode = image transfer) |
> +                          |-------------------------->|
> +                          |                           |
> +                          |         READ_DATA         |
> +                          |   (img ID:34, 0, offset,  |
> +                          | size of DDR training data)|
> +                          |<--------------------------|
> +                          |                           |
> +                          |         RAW_DATA          |
> +                          |(size of DDR training data)|
> +                          |-------------------------->|
> +                          |                           |
> +                          |                           |
> +                          |       END_IMAGE_TX        |
> +                          |<--------------------------|
> +                          |                           |
> +                          |                           |
> +                          |          DONE             |
> +                          |-------------------------->|
> +                          |                           |
> +                          |                           |
> +                          |         DONE_RESP         |
> +                          | (mode = IMAGE_TX_PENDING) |
> +                          |<--------------------------|
> +                          |                           |
> +                          | Subsequent boot scenario  |
> +                          | (valid calibration data)  |
> +                          | DDR driver configures DDR |
> +                          | using valid calibration   |
> +                          | data                      |
> +                          |                           |
> +                          |                           |
> +                          |          HELLO            |
> +                          | (mode = IMAGE_TX_PENDING) |
> +                          |<--------------------------|
> +                          |                           |
> +                          |         HELLO RESP        |
> +                          | (mode = IMAGE_TX_PENDING) |
> +                          |-------------------------->|
> +                          |                           |
> +                          | Boot/Load rest of the     |
> +                          |    images....             |
> +                          |                           |
> +                          |       END_IMAGE_TX        |
> +                          |<--------------------------|
> +                          |                           |
> +                          |                           |
> +                          |          DONE             |
> +                          |-------------------------->|
> +                          |                           |
> +                          |                           |
> +                          |         DONE_RESP         |
> +                          |(mode = IMAGE_TX_COMPLETE) |
> +                          |<--------------------------|
> +                          |                           |
> +
> +The packet flow is as follows :
> +

s/as follows :/as follows:/
in 2 places.

> +1. The target sends the hello packet to the host to initiate the protocol
> +   with the mode set to image transfer pending.

-- 
~Randy

