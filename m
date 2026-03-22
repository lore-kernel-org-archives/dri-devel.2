Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 776E9FC72CB
	for <dri-devel@archiver.kernel.org>; Sun, 22 Mar 2026 17:46:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B59AC10E068;
	Sun, 22 Mar 2026 17:46:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="nIYI3nU9";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5702210E068
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 17:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774201574; x=1805737574;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=0psMeQIAJF2GCZNSxGc5OMzULl9ytU8E7LNJwnaKs3c=;
 b=nIYI3nU9EJj8YRunrY3pGdpcSP3WjBD0u2JSlSdlwYPdWsPqTQ7YIR75
 9ffM214ulUMy4Tz5sWlIKEcY4VPA53i7MnU8PddwTP0tMml79c/PWlSwo
 ESv7UAtJqJr9oIE+qJP2tWZJ4JB3Jy+jmkbPN6YOFVNjXat0zwVVPP3p+
 EiehqyggmIGZTVOYZ5e3+y34BLQ50nc1r7lu41Dry+Jn5ovqjB+Uubx+F
 wjs1JrKkZ+BDZAIbgDqiHY5HcKW7DRFR05cn/lqxeRvpicqRmyCdxbs+X
 LvUgGYjtxXsLSJkhpJWe+YtVW4B8UrT5d92AiKRLvJNgSy3ywziIaAuqT A==;
X-CSE-ConnectionGUID: YY7U3o2CQFGUAvI5z/nksw==
X-CSE-MsgGUID: 2SuGV6UdTc+kJ8KoVTa4Zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="75242588"
X-IronPort-AV: E=Sophos;i="6.23,135,1770624000"; d="scan'208";a="75242588"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2026 10:46:14 -0700
X-CSE-ConnectionGUID: R464xp4/SeSKVLkTwl5LoA==
X-CSE-MsgGUID: IdYGn02MTD6Vo73ZXIquNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,135,1770624000"; d="scan'208";a="223019749"
Received: from lkp-server02.sh.intel.com (HELO d7fefbca0d04) ([10.239.97.151])
 by orviesa010.jf.intel.com with ESMTP; 22 Mar 2026 10:46:10 -0700
Received: from kbuild by d7fefbca0d04 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1w4MsJ-000000002TN-2ZPb;
 Sun, 22 Mar 2026 17:46:07 +0000
Date: Mon, 23 Mar 2026 01:39:47 +0800
From: kernel test robot <lkp@intel.com>
To: Kishore Batta <kishore.batta@oss.qualcomm.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, andersson@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, mhi@lists.linux.dev,
 Kishore Batta <kishore.batta@oss.qualcomm.com>
Subject: Re: [PATCH v4 7/9] bus: mhi: Capture DDR training data using command
 mode
Message-ID: <202603230107.6EzMoVPn-lkp@intel.com>
References: <20260319-sahara_protocol_new_v2-v4-7-47ad79308762@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319-sahara_protocol_new_v2-v4-7-47ad79308762@oss.qualcomm.com>
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

Hi Kishore,

kernel test robot noticed the following build warnings:

[auto build test WARNING on a0ae2a256046c0c5d3778d1a194ff2e171f16e5f]

url:    https://github.com/intel-lab-lkp/linux/commits/Kishore-Batta/Add-documentation-for-Sahara-protocol/20260320-144614
base:   a0ae2a256046c0c5d3778d1a194ff2e171f16e5f
patch link:    https://lore.kernel.org/r/20260319-sahara_protocol_new_v2-v4-7-47ad79308762%40oss.qualcomm.com
patch subject: [PATCH v4 7/9] bus: mhi: Capture DDR training data using command mode
config: i386-randconfig-141-20260322 (https://download.01.org/0day-ci/archive/20260323/202603230107.6EzMoVPn-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
smatch: v0.5.0-9004-gb810ac53

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603230107.6EzMoVPn-lkp@intel.com/

New smatch warnings:
drivers/bus/mhi/sahara/sahara.c:639 sahara_command_execute_resp() warn: unsigned '(context->rx->command_execute_resp.response_length)' is never less than zero.

Old smatch warnings:
drivers/bus/mhi/sahara/sahara.c:353 sahara_select_variant() warn: this array is probably non-NULL. 'id->chan'

vim +639 drivers/bus/mhi/sahara/sahara.c

   628	
   629	static void sahara_command_execute_resp(struct sahara_context *context)
   630	{
   631		struct device *dev = &context->mhi_dev->mhi_cntrl->mhi_dev->dev;
   632		struct sahara_ctrl_trng_data *ct;
   633		u32 client_cmd, resp_len;
   634		int ret;
   635		u64 remaining;
   636		u32 i;
   637	
   638		if (le32_to_cpu(context->rx->length) != SAHARA_COMMAND_EXEC_RESP_LENGTH ||
 > 639		    le32_to_cpu(context->rx->command_execute_resp.response_length) < 0) {
   640			dev_err(&context->mhi_dev->dev,
   641				"Malformed command execute resp packet - length %d\n",
   642				le32_to_cpu(context->rx->length));
   643			return;
   644		}
   645	
   646		client_cmd = le32_to_cpu(context->rx->command_execute_resp.client_command);
   647		resp_len = le32_to_cpu(context->rx->command_execute_resp.response_length);
   648	
   649		sahara_command_execute_data(context, client_cmd);
   650	
   651		if (client_cmd == SAHARA_EXEC_CMD_GET_COMMAND_ID_LIST) {
   652			sahara_command_execute(context, SAHARA_EXEC_CMD_GET_TRAINING_DATA);
   653			return;
   654		}
   655	
   656		if (client_cmd != SAHARA_EXEC_CMD_GET_TRAINING_DATA)
   657			return;
   658	
   659		ct = sahara_ctrl_trng_get(dev);
   660		if (!ct) {
   661			context->is_cmd_mode = false;
   662			sahara_switch_mode_to_img_tx(context);
   663			return;
   664		}
   665	
   666		mutex_lock(&ct->lock);
   667		kfree(ct->data);
   668		ct->data = kzalloc(resp_len, GFP_KERNEL);
   669		ct->size = resp_len;
   670		ct->copied = 0;
   671		ct->receiving = true;
   672		mutex_unlock(&ct->lock);
   673	
   674		if (!ct->data) {
   675			context->is_cmd_mode = false;
   676			sahara_switch_mode_to_img_tx(context);
   677			return;
   678		}
   679	
   680		context->trng_size = resp_len;
   681		context->trng_rcvd = 0;
   682		context->receiving_trng_data = true;
   683	
   684		remaining = resp_len;
   685		for (i = 0; i < SAHARA_NUM_CMD_BUF && remaining; i++) {
   686			size_t pkt = min_t(size_t, remaining, SAHARA_PACKET_MAX_SIZE);
   687	
   688			ret = mhi_queue_buf(context->mhi_dev, DMA_FROM_DEVICE,
   689					    context->cmd_buff[i], pkt,
   690					    (remaining <= pkt) ? MHI_EOT : MHI_CHAIN);
   691			if (ret)
   692				break;
   693	
   694			remaining -= pkt;
   695		}
   696	
   697		context->trng_nbuf = i;
   698	}
   699	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
